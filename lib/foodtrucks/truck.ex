defmodule Foodtrucks.Truck do
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

  def new(opts) do
    opts = 
      opts 
      |> Enum.into(%{}, fn {k,v} -> {String.to_atom(k), v} end)
      |> Enum.map(&translate/1)
    
    today = DayOfWeek.today_as_string()

    struct(__MODULE__, opts)
    |> set_color_for_open_status(today)
  end

  def translate({:coldtruck, "Y"}), do: {:coldtruck, true}
  def translate({:coldtruck, "N"}), do: {:coldtruck, false}

  def translate({:latitude, latitude}), do: {:latitude, String.to_float(latitude)}
  def translate({:longitude, longitude}), do: {:longitude, String.to_float(longitude)}

  def translate(truck), do: truck

  def set_color_for_open_status(truck, today) do 
    cond do
      truck.dayofweekstr == today -> 
        %{truck | pin_color: "00FF00" }
      true -> 
        %{truck | pin_color: "FF0000"}
        end
  end
end
