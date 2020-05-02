defmodule Coliving.DevicesTest do
  use Coliving.DataCase

  alias Coliving.Devices

  describe "devices" do
    alias Coliving.Devices.Device

    @valid_attrs %{
      client_version: "some client_version",
      device_uuid: "7488a646-e31f-11e4-aace-600308960662",
      hit: 42,
      platform: "some platform",
      push_token: "some push_token"
    }
    @update_attrs %{
      client_version: "some updated client_version",
      device_uuid: "7488a646-e31f-11e4-aace-600308960668",
      hit: 43,
      platform: "some updated platform",
      push_token: "some updated push_token"
    }
    @invalid_attrs %{
      client_version: nil,
      device_uuid: nil,
      hit: nil,
      platform: nil,
      push_token: nil
    }

    def device_fixture(attrs \\ %{}) do
      {:ok, device} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Devices.create_device()

      device
    end

    test "list_devices/0 returns all devices" do
      device = device_fixture()
      assert Devices.list_devices() == [device]
    end

    test "get_device!/1 returns the device with given id" do
      device = device_fixture()
      assert Devices.get_device!(device.id) == device
    end

    test "create_device/1 with valid data creates a device" do
      assert {:ok, %Device{} = device} = Devices.create_device(@valid_attrs)
      assert device.client_version == "some client_version"
      assert device.device_uuid == "7488a646-e31f-11e4-aace-600308960662"
      assert device.hit == 42
      assert device.platform == "some platform"
      assert device.push_token == "some push_token"
    end

    test "create_device/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Devices.create_device(@invalid_attrs)
    end

    test "update_device/2 with valid data updates the device" do
      device = device_fixture()
      assert {:ok, %Device{} = device} = Devices.update_device(device, @update_attrs)
      assert device.client_version == "some updated client_version"
      assert device.device_uuid == "7488a646-e31f-11e4-aace-600308960668"
      assert device.hit == 43
      assert device.platform == "some updated platform"
      assert device.push_token == "some updated push_token"
    end

    test "update_device/2 with invalid data returns error changeset" do
      device = device_fixture()
      assert {:error, %Ecto.Changeset{}} = Devices.update_device(device, @invalid_attrs)
      assert device == Devices.get_device!(device.id)
    end

    test "delete_device/1 deletes the device" do
      device = device_fixture()
      assert {:ok, %Device{}} = Devices.delete_device(device)
      assert_raise Ecto.NoResultsError, fn -> Devices.get_device!(device.id) end
    end

    test "change_device/1 returns a device changeset" do
      device = device_fixture()
      assert %Ecto.Changeset{} = Devices.change_device(device)
    end
  end
end
