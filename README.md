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

config :httpet, :routes,
  beagle: System.get_env("BEAGLE_URL"),
  hamster: System.get_env("HAMSTER_URL"),
  weasel: System.get_env("WEASEL_URL")
```

## Usage

`HTTPet.get(:weasel, "/users/me")`

`HTTPet.get(:weasel, "/users/me", %{"my-custom-header" => "my-custom-value"})`

`HTTPet.put(:weasel, "/users/me", %{name: "my user name"})`

`HTTPet.put(:weasel, "/users/me", %{name: "my user name"}, %{"my-custom-header" => "my-custom-value"})`
