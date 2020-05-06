defmodule Coliving.Models.Room do
  @derive {Jason.Encoder, except: []}
  defstruct [
    :id,
    :name,
    :count,
    :capacity,
    :group,
    :ibeacon_uuid,
    :altbeacon_uuid,
    :major,
    :minor,
    :percentage,
    :css_class,
    :last_updated
  ]
end
