defmodule ColivingWeb.LobbyChannelTests do
  use ColivingWeb.ChannelCase

  alias ColivingWeb.LobbyChannel

  @default_room "Kitchen"

  setup do
    {:ok, _, socket } =
      socket("test", %{})
      |> subscribe_and_join(LobbyChannel, "lobby:" <> @default_room)

    {:ok, socket: socket}
  end

  test "ping replies with status ok", %{socket: socket} do
    ref = push(socket, "ping", %{"hello" => "there"})
    assert_reply ref, :ok, %{"hello" => "there"}
  end

  test "enter the kitchen lobby:Kitchen", %{socket: socket} do
    push(socket, "enter", %{})
    assert_push "enter", %{}
    assert_broadcast "enter", %{}
  end

  test "left the kitchen lobby:Kitchen", %{socket: socket} do
    push(socket, "left", %{})
    assert_push "left", %{}
    assert_broadcast "left", %{}
  end



end
