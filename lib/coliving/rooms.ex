defmodule Coliving.Rooms do
  @moduledoc """
  The Rooms context.
  """

  import Ecto.Query, warn: false
  alias Coliving.Repo

  alias Coliving.Rooms.Room

  @doc """
  Returns the list of rooms.

  ## Examples

      iex> list_rooms()
      [%Room{}, ...]

  """
  def list_rooms do
    Repo.all(
      from r in Room,
        order_by: r.group,
        select: r
    )
  end

  @doc """
  Gets a single room.

  Raises `Ecto.NoResultsError` if the Room does not exist.

  ## Examples

      iex> get_room!(123)
      %Room{}

      iex> get_room!(456)
      ** (Ecto.NoResultsError)

  """
  def get_room!(id), do: Repo.get!(Room, id)

  @doc """
  Returns a room by name

  ## Examples:
    iex> get_room_by_name!("Living room")
    {:ok, %Room{}}

    iex> get_room_by_name!("Living room")
    ** (Ecto.NoResultsError)
  """
  def get_room_by_name!(name), do: Repo.get_by!(Room, name: name)

  @doc """
  Creates a room.

  ## Examples

      iex> create_room(%{field: value})
      {:ok, %Room{}}

      iex> create_room(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_room(attrs \\ %{}) do
    %Room{}
    |> Room.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a room.

  ## Examples

      iex> update_room(room, %{field: new_value})
      {:ok, %Room{}}

      iex> update_room(room, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_room(%Room{} = room, attrs) do
    room
    |> Room.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a room.

  ## Examples

      iex> delete_room(room)
      {:ok, %Room{}}

      iex> delete_room(room)
      {:error, %Ecto.Changeset{}}

  """
  def delete_room(%Room{} = room) do
    Repo.delete(room)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking room changes.

  ## Examples

      iex> change_room(room)
      %Ecto.Changeset{source: %Room{}}

  """
  def change_room(%Room{} = room) do
    Room.changeset(room, %{})
  end

  alias Coliving.Rooms.Usage

  @doc """
  Returns the list of usages.

  ## Examples

      iex> list_usages()
      [%Usage{}, ...]

  """
  def list_usages do
    Repo.all(Usage)
  end

  @doc """
  Gets a single usage.

  Raises `Ecto.NoResultsError` if the Usage does not exist.

  ## Examples

      iex> get_usage!(123)
      %Usage{}

      iex> get_usage!(456)
      {:error, %Ecto.Changeset{}}

  """
  def get_usage!(id), do: Repo.get!(Usage, id)

  @doc """
  Creates a usage.

  ## Examples

      iex> create_usage(%{field: value})
      {:ok, %Usage{}}

      iex> create_usage(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_usage(attrs \\ %{}) do
    %Usage{}
    |> Usage.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a usage.

  ## Examples

      iex> update_usage(usage, %{field: new_value})
      {:ok, %Usage{}}

      iex> update_usage(usage, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_usage(%Usage{} = usage, attrs) do
    usage
    |> Usage.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a usage.

  ## Examples

      iex> delete_usage(usage)
      {:ok, %Usage{}}

      iex> delete_usage(usage)
      {:error, %Ecto.Changeset{}}

  """
  def delete_usage(%Usage{} = usage) do
    Repo.delete(usage)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking usage changes.

  ## Examples

      iex> change_usage(usage)
      %Ecto.Changeset{source: %Usage{}}

  """
  def change_usage(%Usage{} = usage) do
    Usage.changeset(usage, %{})
  end

  alias Coliving.Models

  def get_latest_room_stats(id) do
    room = get_room!(id)
    create_room_model_from_stats(room)
  end

  def get_lobby_stats() do
    list_rooms() |> Enum.map(&create_room_model_from_stats(&1))
  end

  def create_room_model_from_stats(room) do
    percentage = round(room.count / room.limit * 100)

    css_class =
      cond do
        percentage <= 25 -> "green"
        percentage > 25 and percentage <= 75 -> "orange"
        percentage > 75 -> "red"
      end

    %Models.Room{
      id: room.id,
      name: room.name,
      count: room.count,
      limit: room.limit,
      group: room.group,
      last_updated: room.updated_at,
      percentage: percentage,
      css_class: css_class
    }
  end

  def enter_or_leave_the_room(room_id, action) do
    room = get_room!(room_id)
    current_hit = room.count

    if (action == "enter" && room.limit == current_hit) || (action == "left" && current_hit == 0) do
      current_hit
    else
      create_usage(%{
        "action" => action,
        "room_id" => room.id,
        "hit" => current_hit
      })

      count = if action == "left", do: -1, else: +1
      hit = current_hit + count

      update_room(room, %{
        "count" => hit
      })

      hit
    end
  end

  # Temporarily changed the visibility
  def maybe_create_room(name) do
    case Repo.one(
           from r in Room,
             where: r.name == ^name,
             select: r
         ) do
      nil ->
        create_room(%{"name" => name, "count" => 0, "limit" => 15})

      room ->
        {:ok, room}
    end
  end
end
