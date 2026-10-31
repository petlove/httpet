# HTTPet

HTTP client to do calls between services inside the Petlove's ecosystem.

## Installation

Inside your deps on `mix.exs`, with the latest version from
[hex.pm](https://hex.pm/packages/httpet):

```elixir
  {:httpet, "~> 0.1.0"},
```

Releases are described in [RELEASING.md](https://github.com/petlove/httpet/blob/main/RELEASING.md).

## Configuration

```elixir
config :httpet, :tracer, MyApp.Tracer

config :httpet, :services,
  my_internal_service: [
    url: System.get_env("INTERNAL_SERVICE_URL"),
    # Optional, passed to HTTPoison
    timeout: 10_000,
    recv_timeout: 10_000
  ]
```

## Usage

`HTTPet.get(:my_internal_service, "/users/me")`

`HTTPet.get(:my_internal_service, "/users/me", %{"my-custom-header" => "my-custom-value"})`

`HTTPet.put(:my_internal_service, "/users/me", %{name: "my user name"})`

`HTTPet.put(:my_internal_host, "/users/me", %{name: "my user name"}, %{"my-custom-header" => "my-custom-value"})`

`HTTPet.post("http://petlove.com.br", "/users/me", %{name: "my user name"}, %{"my-custom-header" => "my-custom-value"})`
