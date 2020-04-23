import Config

secret_key_base = System.fetch_env!("SECRET_KEY_BASE")
port = System.fetch_env!("PORT")
host = System.fetch_env!("HOST")
database_url = System.fetch_env!("DATABASE_URL")
pool_size = String.to_integer(System.get_env("POOL_SIZE") || "10")

config :coliving, ColivingWeb.Endpoint,
  http: [:inet6, port: String.to_integer(port)],
  secret_key_base: secret_key_base

config :coliving, port: port

config :coliving, host: host

config :coliving, Coliving.Repo,
  url: database_url,
  pool_size: pool_size
