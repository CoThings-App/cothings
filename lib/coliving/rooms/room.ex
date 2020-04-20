defmodule Coliving.Rooms.Room do
  use Ecto.Schema
  import Ecto.Changeset

  @all_fields ~w(name count limit group ibeacon_uuid altbeacon_uuid major minor)a
  @required_fields ~w(name count limit group)a

  schema "rooms" do
    field :name, :string
    # count of people / running machines etc.
    field :count, :integer
    field :limit, :integer
    field :group, :string
    field :ibeacon_uuid, :string
    field :altbeacon_uuid, :string
    field :major, :integer
    field :minor, :integer

    timestamps()
  end

  @doc false
  def changeset(room, attrs) do
    room
    |> cast(attrs, @all_fields)
    |> validate_required(@required_fields)
  end
end
