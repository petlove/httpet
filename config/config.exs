import Config

config :httpet,
  hosts: [],
  tracer: nil

if config_env() == :test do
  config :httpet, :services,
    fake_service: [url: "http://0.0.0.0", timeout: 50_000, recv_timeout: 50_000],
    test_service: [url: "http://0.0.0.1", timeout: 40_000]

  # Mocks (remember keep this list as short as possible)

  config :httpet, :http_client, HTTPet.Clients.ClientBehaviourMock
end
