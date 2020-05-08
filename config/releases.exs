import Config

database_url =
  System.get_env("DATABASE_URL") ||
    raise """
    environment variable DATABASE_URL is missing.
    For example: ecto://USER:PASS@HOST/DATABASE
    """

config :coliving, Coliving.Repo,
  # ssl: true,
  url: database_url,
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")

secret_key_base =
  System.get_env("SECRET_KEY_BASE") ||
    raise """
    environment variable SECRET_KEY_BASE is missing.
    You can generate one by calling: mix phx.gen.secret
    """

config :coliving, ColivingWeb.Endpoint,
  http: [
    port: String.to_integer(System.get_env("PORT") || "4000"),
    transport_options: [socket_opts: [:inet6]]
  ],
  url: [host: System.get_env("HOST"), port: 80],
  server: true,
  cache_static_manifest: "priv/static/cache_manifest.json",
  secret_key_base: secret_key_base

config :coliving,
  app_title: System.get_env("APP_TITLE") || "CoThings",
  usage_logging_enabled: System.get_env("LOG_ROOM_USAGE") || "false",
  usage_logging_enabled_with_device_uuid:
    System.get_env("LOG_ROOM_USAGE_WITH_DEVICE_UUID") || "false",
  socket_auth_enabled: System.get_env("ENABLE_SOCKET_CLIENT_AUTH") || "false"
