# Foodtrucks

## Sample Application:

The application I have created is designed to show my understanding of the following elements:

- OTP
- Use of External APIs
- Phoenix with LiveView
- JavaScript & TailwindCSS

## Demo 

You can access the hosted demo [here](https://gary-food-truck.gigalixirapp.com). When the application is launched, it requests the information from the SF Gov API, caching it in memory. The data is refreshed every 60 minutes, and all UI requests are sourced from the cache. 

## Design

The UI presents a retro-styled map centered on the data area. Pins are dropped 1 second after the page is rendered using LiveView push_events. 

The pins are colored:
- <span style="color:green">green</span> to represent the food truck being open, 
- <span style="color:red">red</span> to show it's closed. 

Clicking on a pin shows an information page, details include the day the day and times the truck is open.

As this is a demo application, no attempt was made to deal with refresh happening just before midnight and incorrect colors being shown for up to 59 minutes. This issue could have been resolved using [Quantum](https://hex.pm/packages/quantum) and creating a task to invalidate the cache.

## Test & DocTests

Some test have been added to show knowledge of testing, also added DocTests in [test/foodtrucks/day_of_week_test.exs](test/foodtrucks/day_of_week_test.exs)

## Dependencies

```elixir
{:tailwind, "~> 0.1.9"},
{:cachex, "~> 3.4"},
{:exsoda, "~> 5.0"}
```

### [ Tailwind ](https://hex.pm/packages/tailwind)

I'm using this library to integrate with the TailwindCSS *utility first* framework.

### [ Cachex ](https://hex.pm/packages/cachex)

The library allows the application to either reactively or proactively warm the cache, and I chose proactive warming to ensure the data was present when the first user visited the site.

The code snippets show how the cache warmer is associated with the cache, and how a cache warmer is structured
#### [lib/foodtrucks/cache.ex](lib/foodtrucks/cache.ex)
```elixir
  def child_spec(_init_args) do
    %{
      id: @cache_table,
      type: :supervisor,
      start: {
        Cachex,
        :start_link,
        [
          @cache_table,
          [
            warmers: [
              warmer(module: Foodtrucks.CacheWarmer, state: "")
            ]
          ]
        ]
      }
    }
  end
```

#### [ lib/foodtrucks/cache_warmer.ex ](lib/foodtrucks/cache_warmer.ex)

The warmer is configured to refresh the cache every 60 minutes.
```elixir
  use Cachex.Warmer
  alias Foodtrucks.Sources.SanFranciscoFoodTruckApi

  def interval, do: :timer.minutes(60)

  def execute(_args) do
    data = SanFranciscoFoodTruckApi.get_the_data()
    {:ok, data, [ttl: :timer.minutes(60)]}
  end
```

### exsoda

This library is a thin wrapper for the socrata Soda2 open API and is the recommended way of accessing the SFGOV API for elixir.

I'm using its query and streaming capabilities to warm and refresh the cache.

```elixir
defmodule Foodtrucks.Sources.SanFranciscoFoodTruckApi do
  import Exsoda.Reader

  alias Foodtrucks.Truck

  def get_the_data() do
    with {:ok, stream} <- query("jjew-r69b", domain: "data.sfgov.org") |> run do
      stream |> Enum.map(&parse_truck/1)
    end
  end

  defp parse_truck(truck_permit_data) do
    truck = truck_permit_data |> Truck.new()

    {truck.permit, truck}
  end
end
```

