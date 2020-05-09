defmodule ColivingWeb.PageView do
  use ColivingWeb, :view


  @green "#81a05a"
  @red "#ff0000"
  @yellow "#ffc300"

  def get_room_percentage(room) do
    ColivingWeb.SharedView.get_room_percentage(room)
  end

  def get_donut_percentage_array(room) do
    per = get_room_percentage(room)
    case per do
       100  -> "100 0"
        _ ->  "#{per} #{100 - per}"
    end

  end

  def get_percentage_color(percentage) do
    # = get_room_percentage(room)
    cond do
      percentage <= 60 -> @green
      percentage > 60 and percentage <= 80 -> @yellow
      percentage > 80 -> @red
    end
  end

end
