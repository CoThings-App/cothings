defmodule ColivingWeb.PageControllerTest do
  use ColivingWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Co-Living Portal"
  end
end
