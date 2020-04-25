use Mix.Config

# Configure your database
config :coliving, Coliving.Repo,
  username: "postgres",
  password: "postgres",
  database: "coliving_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# Configure the database for GitHub Actions
if System.get_env("GITHUB_ACTIONS") do
  config :coliving, Coliving.Repo,
    username: "postgres",
    password: "postgres"
end

if System.get_env("GITLAB_CI") do
  config :coliving, Coliving.Repo, hostname: "postgres"
end

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :coliving, ColivingWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
