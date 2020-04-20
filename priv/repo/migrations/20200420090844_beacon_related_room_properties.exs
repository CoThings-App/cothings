defmodule Coliving.Repo.Migrations.IbeaconRelatedRoomProperties do
  use Ecto.Migration

  def change do
    alter table(:rooms) do
      add :ibeacon_uuid, :string
      add :altbeacon_uuid, :string
      add :major, :integer
      add :minor, :integer
    end
  end
end
