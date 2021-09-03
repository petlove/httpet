defmodule HTTPet.ServiceUrl do
  def build(service, path) do
    service
    |> resolve_service_host()
    |> resolve_service_url(path)
  end

  defp resolve_service_host(service) when is_atom(service) do
    :httpet
    |> Application.get_env(:hosts, [])
    |> Keyword.get(service, Atom.to_string(service))
  end

  defp resolve_service_host(service) when is_binary(service), do: service

  defp resolve_service_url(host, path) do
    URI.parse()

    host
    |> URI.parse()
    |> URI.merge(path)
    |> URI.to_string()
  end
end
