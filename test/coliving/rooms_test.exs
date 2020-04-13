defmodule Coliving.RoomsTest do
  use Coliving.DataCase

  alias Coliving.Rooms

  describe "rooms" do
    alias Coliving.Rooms.Room

    @valid_attrs %{count: 42, limit: 42, name: "some name"}
    @update_attrs %{count: 43, limit: 43, name: "some updated name"}
    @invalid_attrs %{count: nil, limit: nil, name: nil}

    def room_fixture(attrs \\ %{}) do
      {:ok, room} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Rooms.create_room()

      room
    end

    test "list_rooms/0 returns all rooms" do
      room = room_fixture()
      assert Rooms.list_rooms() == [room]
    end

    test "get_room!/1 returns the room with given id" do
      room = room_fixture()
      assert Rooms.get_room!(room.id) == room
    end

    test "create_room/1 with valid data creates a room" do
      assert {:ok, %Room{} = room} = Rooms.create_room(@valid_attrs)
      assert room.count == 42
      assert room.limit == 42
      assert room.name == "some name"
    end

    test "create_room/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Rooms.create_room(@invalid_attrs)
    end

    test "update_room/2 with valid data updates the room" do
      room = room_fixture()
      assert {:ok, %Room{} = room} = Rooms.update_room(room, @update_attrs)
      assert room.count == 43
      assert room.limit == 43
      assert room.name == "some updated name"
    end

    test "update_room/2 with invalid data returns error changeset" do
      room = room_fixture()
      assert {:error, %Ecto.Changeset{}} = Rooms.update_room(room, @invalid_attrs)
      assert room == Rooms.get_room!(room.id)
    end

    test "delete_room/1 deletes the room" do
      room = room_fixture()
      assert {:ok, %Room{}} = Rooms.delete_room(room)
      assert_raise Ecto.NoResultsError, fn -> Rooms.get_room!(room.id) end
    end

    test "change_room/1 returns a room changeset" do
      room = room_fixture()
      assert %Ecto.Changeset{} = Rooms.change_room(room)
    end
  end

  describe "usages" do
    alias Coliving.Rooms.Usage

    @valid_attrs %{action: "some action", hit: 42}
    @update_attrs %{action: "some updated action", hit: 43}
    @invalid_attrs %{action: nil, hit: nil}

    def usage_fixture(attrs \\ %{}) do
      {:ok, usage} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Rooms.create_usage()

      usage
    end

    test "list_usages/0 returns all usages" do
      usage = usage_fixture()
      assert Rooms.list_usages() == [usage]
    end

    test "get_usage!/1 returns the usage with given id" do
      usage = usage_fixture()
      assert Rooms.get_usage!(usage.id) == usage
    end

    test "create_usage/1 with valid data creates a usage" do
      assert {:ok, %Usage{} = usage} = Rooms.create_usage(@valid_attrs)
      assert usage.action == "some action"
      assert usage.hit == 42
    end

    test "create_usage/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Rooms.create_usage(@invalid_attrs)
    end

    test "update_usage/2 with valid data updates the usage" do
      usage = usage_fixture()
      assert {:ok, %Usage{} = usage} = Rooms.update_usage(usage, @update_attrs)
      assert usage.action == "some updated action"
      assert usage.hit == 43
    end

    test "update_usage/2 with invalid data returns error changeset" do
      usage = usage_fixture()
      assert {:error, %Ecto.Changeset{}} = Rooms.update_usage(usage, @invalid_attrs)
      assert usage == Rooms.get_usage!(usage.id)
    end

    test "delete_usage/1 deletes the usage" do
      usage = usage_fixture()
      assert {:ok, %Usage{}} = Rooms.delete_usage(usage)
      assert_raise Ecto.NoResultsError, fn -> Rooms.get_usage!(usage.id) end
    end

    test "change_usage/1 returns a usage changeset" do
      usage = usage_fixture()
      assert %Ecto.Changeset{} = Rooms.change_usage(usage)
    end

    test "create usage with room name and action should creates the room if it does not exist" do
      hit = Rooms.enter_or_leave_the_room("Kitchen", "enter")
      assert hit == 1
      room = Rooms.get_room_by_name!("Kitchen")
      assert room.id != nil
      assert room.count == 1
      assert room.limit == 15
    end
  end
end
