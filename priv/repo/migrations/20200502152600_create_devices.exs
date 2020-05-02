defmodule Coliving.Repo.Migrations.CreateDevices do
  use Ecto.Migration

  def change do
    create table(:devices) do
      add :device_uuid, :uuid
      add :platform, :string
      add :push_token, :string
      add :client_version, :string
      add :hit, :integer

      timestamps()
    end

    create unique_index(:devices, [:device_uuid])
  end
end
