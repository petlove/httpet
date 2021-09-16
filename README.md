<img src="https://g.codefresh.io/api/badges/pipeline/petlove/HTTPet%2Fcheck?key=eyJhbGciOiJIUzI1NiJ9.NWIyN2RiNmQyYjY5MjEwMDAxOTA1ODdm.qez6HSUlYqd-f3hjUFyhvQ5ufsmpe8IzOpKpQ_a0RPs&date=1631649692026" />

# HTTPet

HTTP client to do calls between services inside the Petlove's ecosystem.

## Installation

Inside your deps on `mix.exs`:

```elixir
  {:httpet, git: "git@github.com:petlove/HTTPet.git"},
```

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
