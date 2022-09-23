defmodule HTTPet do
  @moduledoc """
  Documentation for `HTTPet`.
  """

  alias HTTPet.{RequestHeaders, ServiceUrl}

  def get(service, path, headers \\ [], opts \\ []) do
    url = ServiceUrl.build(service, path)
    headers = RequestHeaders.add_defaults(headers)

    http_client().get(url, headers, merge_service_options(service, opts))
  end

  def post(service, path, payload, headers \\ [], opts \\ []) do
    url = ServiceUrl.build(service, path)
    headers = RequestHeaders.add_defaults(headers)

    with {:ok, payload} <- Jason.encode(payload) do
      http_client().post(url, payload, headers, merge_service_options(service, opts))
    end
  end

  def put(service, path, payload, headers \\ [], opts \\ []) do
    url = ServiceUrl.build(service, path)
    headers = RequestHeaders.add_defaults(headers)

    with {:ok, payload} <- Jason.encode(payload) do
      http_client().put(url, payload, headers, merge_service_options(service, opts))
    end
  end

  def patch(service, path, payload, headers \\ [], opts \\ []) do
    url = ServiceUrl.build(service, path)
    headers = RequestHeaders.add_defaults(headers)

    with {:ok, payload} <- Jason.encode(payload) do
      http_client().patch(url, payload, headers, merge_service_options(service, opts))
    end
  end

  def delete(service, path, headers \\ [], opts \\ []) do
    url = ServiceUrl.build(service, path)
    headers = RequestHeaders.add_defaults(headers)

    http_client().delete(url, headers, merge_service_options(service, opts))
  end

  # config :httpet, :http_client, HTTPet.Clients.HTTPoison
  defp http_client do
    Application.get_env(:httpet, :http_client, HTTPet.Clients.HTTPoison)
  end

  defp merge_service_options(service, opts) do
    :httpet
    |> Application.get_env(:services, [])
    |> Keyword.get(service, [])
    |> Keyword.delete(:url)
    |> Keyword.merge(opts)
  end
end
