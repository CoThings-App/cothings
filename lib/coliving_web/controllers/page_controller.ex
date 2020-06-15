defmodule ColivingWeb.PageController do
  use ColivingWeb, :controller

  alias Coliving.Rooms

  def index(conn, _params) do
    rooms = Rooms.list_rooms() |> Enum.group_by(& &1.group)
    render(conn, "index.html", rooms: rooms)
  end

  def privacy(conn, _params) do
    url = Phoenix.Controller.current_url(conn)
    log_usage_enabled = Application.get_env(:coliving, :usage_logging_enabled)
    server_source_code_url = Application.get_env(:coliving, :server_source_code_url)
    ios_source_code_url = Application.get_env(:coliving, :ios_source_code_url)

    render(conn, "privacy.html",
      layout: {ColivingWeb.LayoutView, "clean.html"},
      log_usage_enabled: log_usage_enabled,
      page_title: "Privacy Policy",
      url: url,
      server_source_code_url: server_source_code_url,
      ios_source_code_url: ios_source_code_url
    )
  end
end
