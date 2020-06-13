defmodule ColivingWeb.ConfigView do
  use ColivingWeb, :view

  def render("config.json", %{data: data}) do
    data
  end
end
