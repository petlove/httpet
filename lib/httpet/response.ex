defmodule HTTPet.Response do
  @moduledoc false

  @type t :: %__MODULE__{
          body: map() | String.t(),
          headers: map(),
          status_code: integer()
        }

  @response_keys [:body, :headers, :status_code]
  @enforce_keys @response_keys
  defstruct @enforce_keys

  def handle(body: body, headers: headers, status_code: status_code) do
    case Jason.decode(body, keys: :atoms) do
      {:ok, decoded_body} ->
        struct(__MODULE__,
          body: decoded_body,
          headers: headers,
          status_code: status_code
        )

      {:error, _} ->
        struct(__MODULE__,
          body: body,
          headers: headers,
          status_code: status_code
        )
    end
  end
end
