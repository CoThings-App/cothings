defmodule ColivingWeb.RoomChannelTests do
  use ColivingWeb.ChannelCase, async: true

  alias ColivingWeb.RoomChannel
  alias ColivingWeb.UserSocket
  alias Coliving.Rooms

  defp create_test_room() do
    {:ok, room} =
      Rooms.create_room(%{
        name: "Test Room",
        count: 0,
        capacity: 10,
        group: "Test Group"
      })

    room
  end

  describe "socket with auth" do
    setup do
      Application.put_env(:coliving, :usage_logging_enabled, true)
      Application.put_env(:coliving, :usage_logging_enabled_with_device_uuid, false)
      Application.put_env(:coliving, :socket_auth_enabled, true)

      room = create_test_room()

      device_uuid = Ecto.UUID.generate()

      device_token = Phoenix.Token.sign(@endpoint, "device token", device_uuid)

      {:ok, _, socket} =
        socket(UserSocket, "device_uuid", %{device_token => device_token})
        |> subscribe_and_join(RoomChannel, "room:lobby")

      {:ok, socket: socket, room: room}
    end

    test "increase room population", %{socket: socket, room: room} do
      push(socket, "inc", %{room_id: room.id})
      assert_push "inc", %{}

      # by setup logging is enabled
      assert Rooms.get_usage_by_room_id(room.id) != nil
    end

    test "increase room population without logging", %{socket: socket, room: room} do
      Application.put_env(:coliving, :usage_logging_enabled, false)
      push(socket, "inc", %{room_id: room.id})
      assert_push "inc", %{}

      assert Rooms.get_usage_by_room_id(room.id) == nil
    end

    test "decrease room population", %{socket: socket, room: room} do
      push(socket, "dec", %{room_id: room.id})
      assert_push "dec", %{}
    end
  end

  describe "socket withouth auth" do
    setup do
      Application.put_env(:coliving, :usage_logging_enabled, true)
      Application.put_env(:coliving, :usage_logging_enabled, true)

      room = create_test_room()

      {:ok, _, socket} =
        socket(UserSocket, "device_uuid", %{})
        |> subscribe_and_join(RoomChannel, "room:lobby")

      {:ok, socket: socket, room: room}
    end

    test "increase room population", %{socket: socket, room: room} do
      push(socket, "inc", %{room_id: room.id})
      assert_push "inc", %{}
    end

    test "decrease room population", %{socket: socket, room: room} do
      push(socket, "dec", %{room_id: room.id})
      assert_push "dec", %{}
    end
  end
end
