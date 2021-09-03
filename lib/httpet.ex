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

  alias HTTPet.{RequestHeaders, ServiceUrl}

  def get(service, path, headers \\ %{}, opts \\ []) do
    url = ServiceUrl.build(service, path)
    headers = RequestHeaders.add_defaults(headers)

    http_client().get(url, headers, opts)
  end

  def post(service, path, payload, headers \\ %{}, opts \\ []) do
    url = ServiceUrl.build(service, path)
    headers = RequestHeaders.add_defaults(headers)

    with {:ok, payload} <- Jason.encode(payload) do
      http_client().post(url, payload, headers, opts)
    end
  end

  def put(service, path, payload, headers \\ %{}, opts \\ []) do
    url = ServiceUrl.build(service, path)
    headers = RequestHeaders.add_defaults(headers)

    with {:ok, payload} <- Jason.encode(payload) do
      http_client().put(url, payload, headers, opts)
    end
  end

  def delete(service, path, headers \\ %{}, opts \\ []) do
    url = ServiceUrl.build(service, path)
    headers = RequestHeaders.add_defaults(headers)

    http_client().delete(url, headers, opts)
  end

  # config :httpet, :http_client, HTTPet.Clients.HTTPoison
  defp http_client do
    Application.get_env(:httpet, :http_client, HTTPet.Clients.HTTPoison)
  end
end
