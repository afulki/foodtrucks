defmodule Foodtrucks.CacheWarmer do
  @moduledoc """
  Cache warmer, uses data from the SF Food truck database
  """

  use Cachex.Warmer
  alias Foodtrucks.Sources.SanFranciscoFoodTruckApi

  def interval, do: :timer.minutes(60)

  def execute(_args) do
    data = SanFranciscoFoodTruckApi.get_the_data()
    {:ok, data, [ttl: :timer.minutes(60)]}
  end
end
