use Mix.Config

# Configure your database
config :coliving, Coliving.Repo,
  username: "postgres",
  password: "postgres",
  database: "coliving_test",
  hostname:  System.get_env("DATABASE_HOSTNAME", "localhost"),
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :coliving, ColivingWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
