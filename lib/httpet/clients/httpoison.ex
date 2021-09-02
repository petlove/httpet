defmodule HTTPet.Clients.HTTPoison do
  alias HTTPet.Clients.ClientBehaviour
  @behaviour ClientBehaviour

  @impl ClientBehaviour
  defdelegate delete(url, headers, options), to: HTTPoison

  @impl ClientBehaviour
  defdelegate get(url, headers, options), to: HTTPoison

  @impl ClientBehaviour
  defdelegate post(url, body, headers, options), to: HTTPoison

  @impl ClientBehaviour
  defdelegate put(url, body, headers, options), to: HTTPoison
end
