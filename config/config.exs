import Config

if config_env() == :test do
  config :httpet, :hosts, fake_service: "http://0.0.0.0"
end
