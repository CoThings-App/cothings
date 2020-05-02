defmodule Coliving.Repo.Migrations.CreateDeviceUUIdForUsages do
  use Ecto.Migration

  def change do
    alter table(:usages) do
      add :device_uuid, :uuid
    end
  end
end
