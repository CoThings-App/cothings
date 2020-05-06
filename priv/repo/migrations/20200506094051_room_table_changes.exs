defmodule Coliving.Repo.Migrations.RoomTableChanges do
  use Ecto.Migration

  def change do
    rename table(:rooms), :limit, to: :capacity
  end
end
