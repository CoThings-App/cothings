defmodule Coliving.Repo do
  use Ecto.Repo,
    otp_app: :coliving,
    adapter: Ecto.Adapters.Postgres
end
