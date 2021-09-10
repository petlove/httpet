import Config

if config_env() == :test do
  config :httpet, :hosts, fake_service: "http://0.0.0.0"

  # Mocks (remember keep this list as short as possible)

  config :httpet, :http_client, HTTPet.Clients.ClientBehaviourMock
end
