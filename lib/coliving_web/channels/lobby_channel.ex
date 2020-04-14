defmodule ColivingWeb.LobbyChannel do
  use ColivingWeb, :channel

  alias Coliving.Rooms

  @room_prefix "lobby:"

  def join(@room_prefix <> room_id, _payload, socket) do
    if room_id == "*" do
      rooms = Rooms.get_lobby_stats()
      {:ok, %{rooms: rooms}, assign(socket, :room_id, room_id)}
    else
      room_id = String.to_integer(room_id)
      room = Rooms.get_latest_room_stats(room_id)
      {:ok, %{room: room}, assign(socket, :room_id, room_id)}
    end
  end

  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  def handle_in(action, _params, socket), do: log_the_action_broadcast(action, socket)

  defp log_the_action_broadcast(action, socket) do
      room_id = socket.assigns.room_id
      if action != "update", do: Rooms.enter_or_leave_the_room(room_id, action)
      data = get_latest_updates(room_id)
      broadcast!(socket, action, data)
      ColivingWeb.Endpoint.broadcast!(@room_prefix <> "*", "update", data) # lets notify homepage as well
      {:reply, :ok, socket}
  end

  defp get_latest_updates(room_id) do
    if room_id == "*" do
      rooms = Rooms.get_lobby_stats()
      %{ rooms: rooms }
    else
      room = Rooms.get_latest_room_stats(room_id)
      %{ room: room }
    end
  end

end
