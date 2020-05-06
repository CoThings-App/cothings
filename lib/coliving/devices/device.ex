defmodule Coliving.Devices.Device do
  use Ecto.Schema
  import Ecto.Changeset

  @all_fields ~w(device_uuid platform push_token client_version hit)a
  @required_fields ~w(device_uuid platform client_version hit)a

  schema "devices" do
    field :client_version, :string
    field :device_uuid, Ecto.UUID
    field :hit, :integer
    field :platform, :string
    field :push_token, :string

    timestamps()
  end

  @doc false
  def changeset(device, attrs) do
    device
    |> cast(attrs, @all_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:device_uuid)
  end
end
