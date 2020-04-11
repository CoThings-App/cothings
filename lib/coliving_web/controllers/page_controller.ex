defmodule ColivingWeb.PageController do
  use ColivingWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
