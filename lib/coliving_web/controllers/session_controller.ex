defmodule ColivingWeb.SessionController do
  use ColivingWeb, :controller

  alias ColivingWeb.Router.Helpers

  @env_admin_password "ADMIN_PASSWORD"

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def login(conn, %{"password" => password}) do
    if System.get_env(@env_admin_password) == password do
      conn
      |> put_flash(:info, "Welcome back!")
      |> put_session(:logged_in, true)
      |> redirect(to: Helpers.room_path(conn, :index))
    else
      conn
      |> put_flash(:error, "Invalid password!")
      |> redirect(to: Helpers.session_path(conn, :index))
    end
  end

  def logout(conn, _params) do
    conn
    |> configure_session(drop: true)
    |> redirect(to: Helpers.page_path(conn, :index))
  end
end
