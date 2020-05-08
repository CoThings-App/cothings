defmodule ColivingWeb.RoomChannel do
  use ColivingWeb, :channel

  alias Coliving.Rooms

  @room_prefix "room:"
  @lobby "lobby"

  def join(@room_prefix <> @lobby, _payload, socket) do
    socket = assign(socket, :device_uuid, socket.assigns[:device_uuid])
    {:ok, %{rooms: Rooms.list_rooms()}, assign(socket, :room_id, @lobby)}
  end

  def handle_in("inc", %{"room_id" => room_id}, socket) do
    {:ok, room} = Rooms.increment_room_population(room_id, socket.assigns[:device_uuid])
    broadcast!(socket, "inc", room)
    {:reply, :ok, socket}
  end

  def handle_in("dec", %{"room_id" => room_id}, socket) do
    {:ok, room} = Rooms.decrement_room_population(room_id, socket.assigns[:device_uuid])
    broadcast!(socket, "dec", room)
    {:reply, :ok, socket}
  end

  @doc """
    Use it from controller in case room name changes
  """
  def broadcast_room_updates(room) do
    ColivingWeb.Endpoint.broadcast!(@room_prefix <> @lobby, "update", %{room: room})
  end
end
