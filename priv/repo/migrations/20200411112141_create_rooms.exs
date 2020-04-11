defmodule Coliving.Repo.Migrations.CreateRooms do
  use Ecto.Migration

  def change do
    create table(:rooms) do
      add :name, :string
      # realtime count
      add :count, :integer
      add :limit, :integer

      timestamps()
    end
  end
end
