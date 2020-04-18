defmodule ColivingWeb.Plugs.SessionPlug do
  import Plug.Conn

  def init(_) do
    # required
  end

  def call(conn, _) do
    logged_in = get_session(conn, :logged_in)

    if logged_in != nil and logged_in == true,
      do: assign(conn, :logged_in, true),
      else: assign(conn, :logged_in, nil)
  end
end
