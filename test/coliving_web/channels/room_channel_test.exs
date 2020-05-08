defmodule ColivingWeb.RoomChannelTests do
  use ColivingWeb.ChannelCase, async: true

  alias ColivingWeb.RoomChannel
  alias ColivingWeb.UserSocket
  alias Coliving.Rooms

  @env_log_room_usage "LOG_ROOM_USAGE"
  @env_log_room_usage_with_device_uuid "LOG_ROOM_USAGE_WITH_DEVICE_UUID"
  @env_enable_socket_client_auth "ENABLE_SOCKET_CLIENT_AUTH"

  describe "socket with auth" do
    setup do

      System.put_env(@env_log_room_usage, "true")
      System.put_env(@env_log_room_usage_with_device_uuid, "false")
      System.put_env(@env_enable_socket_client_auth, "true")

      room = create_test_room()

      device_uuid = Ecto.UUID.generate()

      device_token = Phoenix.Token.sign(@endpoint, "device token", device_uuid)

      {:ok, _, socket} =
        socket(UserSocket, "device_uuid", %{device_token => device_token})
        |> subscribe_and_join(RoomChannel, "room:lobby")

      {:ok, socket: socket, room: room }
    end

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

    test "increase room population", %{socket: socket, room: room} do
      push(socket, "inc", %{room_id: room.id })
      assert_push "inc",  %{}
    end

    test "decrease room population", %{socket: socket, room: room} do
      push(socket, "dec", %{room_id: room.id})
      assert_push "dec", %{}
    end
  end


end
