defmodule Foodtrucks.Cache do
  import Cachex.Spec
  @moduledoc """
  Cache date from the SF Food Truck WebService
  """
  @cache_table :food_trucks

  def cache_name(), do: @cache_table

  def child_spec(_init_args) do
    %{
      id: @cache_table,
      type: :supervisor,
      start: {
        Cachex, :start_link,
        [
          @cache_table,
          [
            warmers: [
              warmer(module: Foodtrucks.CacheWarmer , state: "")
            ]
          ]
        ]
      }
    }
  end
end
