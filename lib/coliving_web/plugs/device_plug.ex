defmodule ColivingWeb.Plugs.DevicePlug do
  @moduledoc """
    `DevicePlug` is only for web client. It checks if the client has an _unique_ `device_token` registered in the cookies,
    if doesn't have one it creates a new one, signed and save it the cookie.
  """

  import Plug.Conn

  alias Coliving.Devices

  # 6 months
  @cookie_max_age 15_778_476

  def init(_) do
    # required
  end

  def call(conn, _) do
    case Application.get_env(:coliving, :socket_auth_enabled) do
      true ->
        create_unique_device_uuid(conn)

      false ->
        conn
    end
  end

  defp create_unique_device_uuid(conn) do
    conn = fetch_cookies(conn)

    device_token = conn.req_cookies["device_token"]

    device_attrs = %{
      client_version: Application.spec(:coliving, :vsn) |> to_string(),
      device_uuid: "",
      hit: 1,
      platform: "web"
    }

    device_attrs =
      if device_token != nil do
        {:ok, device_uuid} =
          Phoenix.Token.verify(conn, "device token", device_token, max_age: @cookie_max_age)

        %{device_attrs | device_uuid: device_uuid}
      else
        uuid = Ecto.UUID.generate()
        %{device_attrs | device_uuid: uuid}
      end

    device = maybe_create_or_update_device(device_attrs)

    conn |> save_device_uuid_and_sign_as_token(device.device_uuid)
  end

  defp save_device_uuid_and_sign_as_token(conn, device_uuid) do
    device_token = sign_device_uuid(conn, device_uuid)

    put_resp_cookie(conn, "device_token", device_token, max_age: @cookie_max_age)
    |> assign(:device_token, device_token)
  end

  defp sign_device_uuid(conn, device_uuid),
    do: Phoenix.Token.sign(conn, "device token", device_uuid)

  defp maybe_create_or_update_device(device_attrs) do
    uuid = device_attrs.device_uuid

    case Devices.get_device_by_uuid(uuid) do
      nil -> create_device(device_attrs)
      device -> update_device(device, device_attrs)
    end
  end

  defp create_device(device_attrs) do
    {:ok, device} = Devices.create_device(device_attrs)
    device
  end

  defp update_device(device, device_attrs) do
    device_attrs = %{device_attrs | hit: device.hit + 1}
    {:ok, device} = Devices.update_device(device, device_attrs)
    device
  end
end
