defmodule ColivingWeb.SessionControllerTest do
  use ColivingWeb.ConnCase

  @env_admin_username "ADMIN_USERNAME"
  @env_admin_password "ADMIN_PASSWORD"
  # random generated
  @admin_username "admin"
  @admin_password "TxJSgE2ukmbM0K"
  # random generated
  @random_password "dOfY9Slsmybn"

  setup %{conn: conn} do
    {:ok, conn: conn}
  end

  test "redirects to login page when user is not logged in", %{conn: conn} do
    conn = get(conn, Routes.room_path(conn, :index))
    assert redirected_to(conn) == Routes.session_path(conn, :index)
  end

  test "shows login form", %{conn: conn} do
    conn = get(conn, Routes.session_path(conn, :index))
    assert html_response(conn, 200) =~ "Password"
  end

  test "user cannot login when user password is not defined in environment variables", %{
    conn: conn
  } do
    conn =
      post(conn, Routes.session_path(conn, :login), %{
        username: @admin_username,
        password: @random_password
      })

    assert get_flash(conn, :error) == "Invalid password!"
    assert redirected_to(conn) == Routes.session_path(conn, :index)
  end

  test "user logins when environment variables set and password is correct", %{conn: conn} do
    System.put_env(@env_admin_username, @admin_username)
    System.put_env(@env_admin_password, @admin_password)

    conn =
      post(conn, Routes.session_path(conn, :login), %{
        username: @admin_username,
        password: @admin_password
      })

    assert get_flash(conn, :info) == "Welcome back!"
    assert redirected_to(conn) == Routes.room_path(conn, :index)
  end

  test "user login fails when environment variables set and password is incorrect", %{conn: conn} do
    System.put_env(@env_admin_username, @admin_username)
    System.put_env(@env_admin_password, @admin_password)

    conn =
      post(conn, Routes.session_path(conn, :login), %{
        username: @admin_username,
        password: @random_password
      })

    assert get_flash(conn, :error) == "Invalid password!"
    assert redirected_to(conn) == Routes.session_path(conn, :index)
  end
end
