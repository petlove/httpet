defmodule HTTPet.Clients.ClientBehaviour do
  @moduledoc false

  alias HTTPet.Response

  @callback delete(String.t(), list(), list()) :: {:ok, Response.t()} | {:error, any()}
  @callback get(String.t(), list(), list()) :: {:ok, Response.t()} | {:error, any()}
  @callback post(String.t(), any(), list(), list()) :: {:ok, Response.t()} | {:error, any()}
  @callback put(String.t(), any(), list(), list()) :: {:ok, Response.t()} | {:error, any()}
end
