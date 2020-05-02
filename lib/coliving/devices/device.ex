defmodule Coliving.Devices.Device do
  use Ecto.Schema
  import Ecto.Changeset

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
    |> cast(attrs, [:device_uuid, :platform, :push_token, :client_version, :hit])
    |> validate_required([:device_uuid, :platform, :push_token, :client_version, :hit])
    |> unique_constraint(:device_uuid)
  end
end
