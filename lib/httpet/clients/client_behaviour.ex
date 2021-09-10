defmodule HTTPet.Clients.ClientBehaviour do
  alias HTTPet.Response

  @callback delete(String.t(), map(), list()) :: {:ok, Response.t()} | {:error, any()}
  @callback get(String.t(), map(), list()) :: {:ok, Response.t()} | {:error, any()}
  @callback post(String.t(), any(), map(), list()) :: {:ok, Response.t()} | {:error, any()}
  @callback put(String.t(), any(), map(), list()) :: {:ok, Response.t()} | {:error, any()}
end
