defmodule ColivingWeb.SessionPlugTest do
  use ColivingWeb.ConnCase

  alias ColivingWeb.Router.Helpers

  setup %{conn: conn} do
    conn =
      conn
      |> bypass_through(ColivingWeb.Router, :browser)

    {:ok, conn: conn}
  end

  test "conn will assign parameters if user has logged in", %{conn: conn} do
    conn = conn |> assign(:logged_in, true)
    assert conn.assigns[:logged_in] == true
  end

  test "conn will remove assign parameters when user logouts", %{conn: conn} do
    conn =
      conn
      |> get(Helpers.session_path(conn, :logout))

    assert conn.assigns[:logged_in] == nil
  end
end
