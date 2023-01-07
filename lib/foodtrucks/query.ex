defmodule Foodtrucks.Query do
  @moduledoc """
  Functions to aid in querying the cache
  """
  import Cachex.Spec
  alias Foodtrucks.{Cache, DayOfWeek}

  def all do
    Cache.cache_name()
    |> Cachex.stream!()
    |> Enum.flat_map(fn entry(value: truck) -> [truck] end)
  end

  def open_today() do
    today = DayOfWeek.date_to_day_string()

    Cache.cache_name()
    |> Cachex.stream!()
    |> Enum.flat_map(fn entry(value: truck) ->
      cond do
        truck.dayofweekstr == today -> [truck]
        true -> []
      end
    end)
  end
end
