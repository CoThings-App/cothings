defmodule Coliving.Repo.Migrations.CreateUserIdForUsagesAndNotifications do
  use Ecto.Migration

  def change do
    alter table(:usages) do
      add :user_id, :binary_id
    end
  end
end
