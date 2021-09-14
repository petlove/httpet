# HTTPet

HTTP client to do calls between services inside the Petlove's ecosystem.

## Installation

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
