defmodule Coliving.Models.Room do
  @derive {Jason.Encoder, except: []}
  defstruct [:id, :name, :count, :limit, :group, :percentage, :css_class, :last_updated]
end
