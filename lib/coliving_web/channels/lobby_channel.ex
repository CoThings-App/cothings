defmodule ColivingWeb.LobbyChannel do
  use ColivingWeb, :channel

  alias Coliving.Rooms

  @default_room "Kitchen"
  @action_enter "enter"
  @action_left "left"

  def join("lobby:" <> @default_room, _payload, socket) do
    # creating a non-exist room on join is temporary
    # TODO: remove this when multiple room support comes
    {:ok, room } = Rooms.maybe_create_room(@default_room)
    {:ok, %{count: room.count, last_updated: room.updated_at }, socket}
  end

  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  def handle_in(@action_enter, _params, socket),
    do: log_the_action_broadcast(@action_enter, socket)

  def handle_in(@action_left, _params, socket), do: log_the_action_broadcast(@action_left, socket)

  defp log_the_action_broadcast(action, socket) do
    hit = Rooms.enter_or_leave_the_room(@default_room, action)
    broadcast!(socket, action, %{count: hit, last_updated: DateTime.utc_now()})
    {:reply, :ok, socket}
  end
end
