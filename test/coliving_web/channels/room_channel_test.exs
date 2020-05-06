defmodule ColivingWeb.RoomChannelTests do
  use ColivingWeb.ChannelCase

  alias ColivingWeb.RoomChannel
  alias ColivingWeb.UserSocket
  alias Coliving.Rooms

  setup do
    room = create_test_room()

    {:ok, _, socket} =
      socket(UserSocket, "device_uuid", %{some: :assign})
      |> subscribe_and_join(RoomChannel, "room:#{room.id}")

    {:ok, socket: socket}
  end

  defp create_test_room() do
    {:ok, room} =
      Rooms.create_room(%{
        name: "Test Room",
        count: 0,
        limit: 10,
        group: "Test Group"
      })

    room
  end

  test "ping replies with status ok", %{socket: socket} do
    ref = push(socket, "ping", %{"hello" => "there"})
    assert_reply ref, :ok, %{"hello" => "there"}
  end

  test "enter a room", %{socket: socket} do
    push(socket, "inc", %{})
    assert_push "inc", %{}
    assert_broadcast "inc", %{}
  end

  test "leave a room", %{socket: socket} do
    push(socket, "dec", %{})
    assert_push "dec", %{}
    assert_broadcast "dec", %{}
  end
end
