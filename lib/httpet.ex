defmodule HTTPet do
  @moduledoc """
  Documentation for `HTTPet`.

  Usage:

  `HTTPet.get(:weasel, "/users/me")`

  `HTTPet.get(:weasel, "/users/me", %{"my-custom-header" => "my-custom-value"})`

  `HTTPet.put(:weasel, "/users/me", %{name: "my user name"})`

  Configuration:

  ```
  config :httpet, :hosts,
    weasel: "asdasd",
    shark: "asdasda",
    beagle: "asdads"

  config :httpet, :http_client, HTTPet.Clients.HTTPoison # (default)

  config :httpet, :tracer, MyApp.Tracer # (only supported Tracers that uses Spandex.Tracer)
  ```
  """

  alias HTTPet.ServiceUrl

  def get(service, path, headers \\ %{}, opts \\ []) do
    url = ServiceUrl.build(service, path)

    http_client().get(url, merge_headers(headers), opts)
  end

  def post(service, path, payload, headers \\ %{}, opts \\ []) do
    url = ServiceUrl.build(service, path)
    encoded_payload = Jason.encode(payload)

    http_client().post(url, encoded_payload, merge_headers(headers), opts)
  end

  def put(service, path, payload, headers \\ %{}, opts \\ []) do
    url = ServiceUrl.build(service, path)
    encoded_payload = Jason.encode(payload)

    http_client().put(url, encoded_payload, merge_headers(headers), opts)
  end

  def delete(service, path, headers \\ %{}, opts \\ []) do
    url = ServiceUrl.build(service, path)
    http_client().delete(url, merge_headers(headers), opts)
  end

  # config :httpet, :http_client, HTTPet.Clients.HTTPoison
  defp http_client do
    Application.get_env(:httpet, :http_client, HTTPet.Clients.HTTPoison)
  end

  defp tracer do
    Application.get_env(:httpet, :tracer)
  end

  defp merge_headers(headers) do
    common_header = %{"Content-Type" => "application/json"}

    case tracer() do
      nil ->
        common_header

      tracer ->
        common_header
        |> Map.put("x-datadog-trace-id", tracer.current_trace_id())
        |> Map.put("x-datadog-parent-id", tracer.current_span_id())
    end
    |> Map.merge(headers)
  end
end
