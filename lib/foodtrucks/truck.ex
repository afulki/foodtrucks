defmodule Foodtrucks.Truck do
  @moduledoc """
  Structure containing the properties of a food truck permit. 
  """
  alias Foodtrucks.DayOfWeek

  @derive Jason.Encoder
  defstruct applicant: "",
            permit: nil,
            location: "",
            coldtruck: "",
            dayofweekstr: "",
            latitude: "",
            longitude: "",
            start24: "",
            end24: "",
            pin_color: "00FF00",
            optionaltext: ""

  @doc """
  Create a %Truck{} from the list of attributes, setting the color of the pin as appropriate
  based on the current day of the week and the opening day of the food truck.
  """
  def new(opts) do
    opts =
      opts
      |> Enum.into(%{}, fn {k, v} -> {String.to_atom(k), v} end)
      |> Enum.map(&translate/1)

    today = DayOfWeek.date_to_day_string()

    struct(__MODULE__, opts)
    |> set_color_for_open_status(today)
  end

  defp translate({:coldtruck, "Y"}), do: {:coldtruck, true}
  defp translate({:coldtruck, "N"}), do: {:coldtruck, false}

  defp translate({:latitude, latitude}), do: {:latitude, String.to_float(latitude)}
  defp translate({:longitude, longitude}), do: {:longitude, String.to_float(longitude)}

  defp translate(truck), do: truck

  defp set_color_for_open_status(truck, today) do
    cond do
      truck.dayofweekstr == today ->
        %{truck | pin_color: "25C55E"}

      true ->
        %{truck | pin_color: "EF4444"}
    end
  end
end
