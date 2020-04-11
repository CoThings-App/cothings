defmodule Coliving.Repo.Migrations.CreateUsages do
  use Ecto.Migration

  def change do
    create table(:usages) do
      # enter, left, started, stopped, empty etc.
      add :action, :string
      # hit at the time
      add :hit, :integer
      add :room_id, references(:rooms, on_delete: :nothing)

      timestamps()
    end

    create index(:usages, [:room_id])
  end
end
