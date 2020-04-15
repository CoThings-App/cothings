defmodule Coliving.Repo.Migrations.AddGroupToRooms do
  use Ecto.Migration

  def change do
    alter table(:rooms) do
      add :group, :string
    end
    create index(:rooms, [:group])
  end
end
