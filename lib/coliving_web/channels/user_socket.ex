defmodule ColivingWeb.UserSocket do
  use Phoenix.Socket

  channel "lobby:*", ColivingWeb.LobbyChannel

  def connect(%{"token" => token}, socket, _connect_info) do
    case Phoenix.Token.verify(socket, "user socket", token, max_age: 1_209_600) do
      {:ok, device_uuid} ->
        {:ok, assign(socket, :device_uuid, device_uuid)}

      {:error, reason} ->
        :error
    end
  end

  def id(_socket), do: nil
end
