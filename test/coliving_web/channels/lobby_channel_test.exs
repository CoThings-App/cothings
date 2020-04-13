defmodule ColivingWeb.LobbyChannelTests do
  use ColivingWeb.ChannelCase

  alias ColivingWeb.LobbyChannel
  alias ColivingWeb.UserSocket
  alias Coliving.Rooms

  setup do
    room = create_test_room()

    {:ok, _, socket} =
      socket(UserSocket, %{})
      |> subscribe_and_join(LobbyChannel, "lobby:#{room.id}")

    {:ok, socket: socket}
  end

  defp create_test_room() do
    {:ok, room} =
      Rooms.create_room(%{
        name: "Test Room",
        count: 0,
        limit: 10
      })

    room
  end

  test "ping replies with status ok", %{socket: socket} do
    ref = push(socket, "ping", %{"hello" => "there"})
    assert_reply ref, :ok, %{"hello" => "there"}
  end

  test "enter a room", %{socket: socket} do
    push(socket, "enter", %{})
    assert_push "enter", %{}
    assert_broadcast "enter", %{}
  end

  test "leave a room", %{socket: socket} do
    push(socket, "left", %{})
    assert_push "left", %{}
    assert_broadcast "left", %{}
  end
end
