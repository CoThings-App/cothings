defmodule ColivingWeb.AuthPlugTest do
  use ColivingWeb.ConnCase

  import Plug.Conn

  alias ColivingWeb.Router.Helpers

  setup %{conn: conn} do
    conn =
      conn
      |> bypass_through(ColivingWeb.Router, :browser)

    {:ok, conn: conn}
  end

  test "user is redirected to login when try to manage rooms", %{conn: conn} do
    conn =
      conn
      |> get(Helpers.room_path(conn, :index))
      |> ColivingWeb.Plugs.AuthPlug.call(%{})

    assert get_flash(conn, :error) == "You need to login in order to manage"
    assert redirected_to(conn) == Helpers.session_path(conn, :index)
  end

  test "user passes auth when logged_in set", %{conn: conn} do
    conn =
      conn
      |> assign(:logged_in, true)
      |> ColivingWeb.Plugs.AuthPlug.call(%{})

    assert conn.status != 302
  end
end
