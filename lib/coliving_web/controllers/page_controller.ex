defmodule ColivingWeb.PageController do
  use ColivingWeb, :controller

  alias Coliving.Rooms

  def index(conn, _params) do
    rooms = Rooms.list_rooms() |> Enum.group_by(& &1.group)
    render(conn, "index.html", rooms: rooms)
  end
end
