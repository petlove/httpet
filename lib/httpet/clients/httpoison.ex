defmodule HTTPet.Clients.HTTPoison do
  @moduledoc false

  alias HTTPet.Clients.ClientBehaviour
  alias HTTPet.Response

  @behaviour ClientBehaviour

  @impl ClientBehaviour
  def delete(url, headers, options) do
    url
    |> HTTPoison.delete(headers, options)
    |> handle_response()
  end

  @impl ClientBehaviour
  def get(url, headers, options) do
    url
    |> HTTPoison.get(headers, options)
    |> handle_response()
  end

  @impl ClientBehaviour
  def post(url, body, headers, options) do
    url
    |> HTTPoison.post(body, headers, options)
    |> handle_response()
  end

  @impl ClientBehaviour
  def put(url, body, headers, options) do
    url
    |> HTTPoison.put(body, headers, options)
    |> handle_response()
  end

  defp handle_response(response) do
    case response do
      {:ok, %{body: body, headers: headers, status_code: status_code}} ->
        {:ok, Response.handle(body: body, headers: headers, status_code: status_code)}

      {:ok, error} ->
        {:error, error}

      error ->
        error
    end
  end
end
