defmodule Coliving.Rooms.Usage do
  use Ecto.Schema
  import Ecto.Changeset

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
    |> cast(attrs, [:action, :hit])
    |> validate_required([:action, :hit])
  end
end
