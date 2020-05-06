defmodule ColivingWeb.UserSocket do
  use Phoenix.Socket

  channel "lobby:*", ColivingWeb.LobbyChannel

  def connect(params, socket, _connect_info) do
    device_token = params["device_token"]

    if device_token == nil do
      :error
    else
      # after decode device_token maybe we should verify the device_uuid in db as well
      case Phoenix.Token.verify(socket, "device token", device_token, max_age: 1_209_600) do
        {:ok, device_uuid} ->
          {:ok, assign(socket, :device_uuid, device_uuid)}

        {:error, _reason} ->
          :error
      end
    end
  end

  def id(_socket), do: nil
end
