defmodule ColivingWeb.SharedView do
  use ColivingWeb, :view

  def get_room_percentage(room) do
    round(room.count / room.capacity * 100)
  end

  def get_room_css_class(room) do
    percentage = get_room_percentage(room)

    css_class =
      cond do
        percentage <= 60 -> "green"
        percentage > 60 and percentage <= 80 -> "orange"
        percentage > 80 -> "red"
      end

    css_class
  end
end
