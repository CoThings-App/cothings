# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :coliving,
  ecto_repos: [Coliving.Repo]

# Configures the endpoint
config :coliving, ColivingWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "nx/r/7iQ8AX0/lkGxNbAtgGzJgi91FT79DLp04R3FK9/wT4p5lMZGHslNYUt6iuB",
  render_errors: [view: ColivingWeb.ErrorView, accepts: ~w(html json)],
  pubsub_server: ColivingWeb.PubSub,
  live_view: [signing_salt: "/kUBZxe/"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :coliving,
  app_title: System.get_env("APP_TITLE") || "CoThings",
  usage_logging_enabled: System.get_env("LOG_ROOM_USAGE") || "false",
  usage_logging_enabled_with_device_uuid:
    System.get_env("LOG_ROOM_USAGE_WITH_DEVICE_UUID") || "false",
  socket_auth_enabled: System.get_env("ENABLE_SOCKET_CLIENT_AUTH") || "false"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
