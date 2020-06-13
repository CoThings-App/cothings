defmodule ColivingWeb.ConfigControllerTest do
  use ColivingWeb.ConnCase, async: true

  @env_app_title_value "CoThings"
  @env_app_image_url_default_value "http://localhost:4000/images/app_image.jpg"

  setup %{conn: conn} do
    # let's set only one variable
    # we also test the string concation for the url
    Application.put_env(:coliving, :app_title, @env_app_title_value)
    {:ok, conn: conn}
  end

  test "GET /config.json returns pre defined and default values", %{conn: conn} do
    conn = get(conn, "/config.json")

    expected_config = %{
      "app" => %{
        "title" => @env_app_title_value,
        "image_url" => @env_app_image_url_default_value
      }
    }

    assert json_response(conn, 200) == expected_config
  end
end
