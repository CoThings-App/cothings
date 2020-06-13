defmodule ColivingWeb.ConfigController do
  use ColivingWeb, :controller

  def index(conn, _params) do
    data = %{
      "app" => %{
        "title" => Application.get_env(:coliving, :app_title),
        "image_url" => Application.get_env(:coliving, :app_image_url)
      }
    }

    render(conn, "config.json", data: data)
  end
end
