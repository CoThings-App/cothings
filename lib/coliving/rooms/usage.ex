defmodule Coliving.Rooms.Usage do
  use Ecto.Schema
  import Ecto.Changeset

  @all_fields ~w(room_id action hit)a
  @required_fields ~w(room_id action hit)a

  schema "usages" do
    field :room_id, :id
    field :action, :string
    # count of the room at the time
    field :hit, :integer

    timestamps()
  end

  @doc false
  def changeset(usage, attrs) do
    usage
    |> cast(attrs, @all_fields)
    |> validate_required(@required_fields)
  end
end
