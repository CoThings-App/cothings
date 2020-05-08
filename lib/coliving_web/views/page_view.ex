defmodule ColivingWeb.PageView do
  use ColivingWeb, :view

  def get_room_percentage(room) do
    round(room.count / room.capacity * 100)
  end

  def get_donut_percentage_array (room) do
    per = get_room_percentage(room)
    case per do
       {100 } -> "100 0"
        _ ->  "#{per} #{100 - per}"
    end

  end

end
