defmodule ColivingWeb.SessionPlugTest do
  use ColivingWeb.ConnCase

  alias ColivingWeb.Router.Helpers


  setup do
    {:ok, conn: Phoenix.ConnTest.build_conn() }
  end

  test "conn will assign parameters if user has logged in" do
    # conn = build_conn() |>
  end

  test "conn will remove assign parameters when user logouts", %{conn: conn} do
    conn = conn |> bypass_through(ColivingWeb.Router, :browser)
    |> get(Helpers.session_path(conn, :logout))
    assert conn.assigns[:logged_id] == nil
  end



end
