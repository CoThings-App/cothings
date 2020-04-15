defmodule ColivingWeb.PageView do
  use ColivingWeb, :view

  def render("_room_stats.html", assigns) do
    ColivingWeb.SharedView.render("_room_stats.html", assigns)
  end
end
