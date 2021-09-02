defmodule HTTPet.Clients.ClientBehaviour do
  @callback delete(String.t(), map(), list()) :: {:ok, any()} | {:error, any()}
  @callback get(String.t(), map(), list()) :: {:ok, any()} | {:error, any()}
  @callback post(String.t(), any(), map(), list()) :: {:ok, any()} | {:error, any()}
  @callback put(String.t(), any(), map(), list()) :: {:ok, any()} | {:error, any()}
end
