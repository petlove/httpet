# HTTPet

HTTP client to do calls between services inside the Petlove's ecosystem.

## Installation

Inside your deps on `mix.exs`, with the latest version from
[hex.pm](https://hex.pm/packages/httpet):

```elixir
  {:httpet, "~> X.Y"},
```

Releases are described in [RELEASING.md](RELEASING.md).

## Configuration

```elixir
config :httpet, :tracer, MyApp.Tracer

config :httpet, :hosts,
  my_internal_service: System.get_env("INTERNAL_SERVICE_URL")
```

## Usage

`HTTPet.get(:my_internal_service, "/users/me")`

`HTTPet.get(:my_internal_service, "/users/me", %{"my-custom-header" => "my-custom-value"})`

`HTTPet.put(:my_internal_service, "/users/me", %{name: "my user name"})`

`HTTPet.put(:my_internal_host, "/users/me", %{name: "my user name"}, %{"my-custom-header" => "my-custom-value"})`

`HTTPet.post("http://petlove.com.br", "/users/me", %{name: "my user name"}, %{"my-custom-header" => "my-custom-value"})`
