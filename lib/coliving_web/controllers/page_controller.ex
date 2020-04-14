defmodule ColivingWeb.PageController do
  use ColivingWeb, :controller

  alias Coliving.Rooms

  def index(conn, _params) do
    render(conn, "index.html", rooms: Rooms.get_lobby_stats())
  end
end
