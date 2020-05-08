defmodule ColivingWeb.UserSocket do
  use Phoenix.Socket

  # 6 months
  @cookie_max_age 15_778_476

  channel "room:*", ColivingWeb.RoomChannel

  def connect(params, socket, _connect_info) do
    case Application.get_env(:coliving, :socket_auth_enabled) do
      "true" -> auth(params, socket)
      _ -> {:ok, socket}
    end
  end

  defp auth(params, socket) do
    device_token = params["device_token"]

    if device_token == nil do
      :error
    else
      # after decode device_token maybe we should verify the device_uuid in db as well
      case Phoenix.Token.verify(socket, "device token", device_token, max_age: @cookie_max_age) do
        {:ok, device_uuid} ->
          {:ok, assign(socket, :device_uuid, device_uuid)}

        {:error, _reason} ->
          :error
      end
    end
  end

  def id(_socket), do: nil
end
