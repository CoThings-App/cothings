defmodule ColivingWeb.LobbyChannel do
  use ColivingWeb, :channel

  alias Coliving.Rooms

  def join("lobby:" <> room_id, _payload, socket) do
    room_id = String.to_integer(room_id)
    if room_id == 0 do
      rooms = Rooms.get_lobby_stats()
      {:ok, %{rooms: rooms}, assign(socket, :room_id, room_id)}
    else
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
    Rooms.enter_or_leave_the_room(room_id, action)
    room = Rooms.get_latest_room_stats(room_id)
    broadcast!(socket, action, %{room: room})
    {:reply, :ok, socket}
  end
end
