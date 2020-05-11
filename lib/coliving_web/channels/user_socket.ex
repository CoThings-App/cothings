defmodule ColivingWeb.UserSocket do
  use Phoenix.Socket

  channel "room:*", ColivingWeb.RoomChannel

  def connect(_params, socket, _connect_info) do
    {:ok, socket}
  end

  def id(_socket), do: nil
end
