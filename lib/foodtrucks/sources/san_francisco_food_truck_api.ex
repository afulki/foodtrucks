defmodule Foodtrucks.Sources.SanFranciscoFoodTruckApi do
  @moduledoc """
  This module calls JSON endpoint : https://data.sfgov.org/resource/jjew-r69b.json using the EXSODA library
  streaming the data to create a list of "Truck" structures. 

  The JSON returned from the API looks like: 

  {
    "dayorder": "4",
    "dayofweekstr": "Thursday",
    "starttime": "12PM",
    "endtime": "1PM",
    "permit": "18MFF-0028",
    "location": "1118 MISSION ST",
    "locationdesc": "12:00pm-12:10pm",
    "optionaltext": "COLD TRUCK. Deli: bbq chicken skewer, Chinese spring roll, Chinese fried rice/noodle, fried chicken leg/wing, bbq chicken sandwich, chicken cheese burger, burrito, lumpia. Snack: sunflower seeds, muffins, chips, snickers, kit-kat, 10 types of chocolate. Drinks: Coke, 7-Up, Dr. Pepper, Pepsi, Redbull, Vitamin Water, Rockstar, Coconut Juice, Water. Hot drinks: coffee, tea.",
    "locationid": "1163794",
    "start24": "12:00",
    "end24": "13:00",
    "cnn": "9101000",
    "addr_date_create": "2011-08-31T15:46:28.000",
    "addr_date_modified": "2011-08-31T15:46:41.000",
    "block": "3702",
    "lot": "032",
    "coldtruck": "Y",
    "applicant": "SOHOMEI, LLC",
    "x": "6009292.77547",
    "y": "2111720.81017",
    "latitude": "37.778907261461264",
    "longitude": "-122.411420115932955",
    "location_2": {
      "latitude": "37.77890726146126",
      "longitude": "-122.41142011593296",
      "human_address": "{\"address\": \"\", \"city\": \"\", \"state\": \"\", \"zip\": \"\"}"
    }
  """
  import Exsoda.Reader

  alias Foodtrucks.Truck

  @doc """
  Retrieve a list of %Truck{} structures sourced from the sata.sfgov.org api.
  """
  def get_the_data() do
    with {:ok, stream} <- query("jjew-r69b", domain: "data.sfgov.org") |> run do
      stream
      |> Enum.map(&parse_truck/1)
    end
  end

  defp parse_truck(truck_permit_data) do
    truck = truck_permit_data |> Truck.new()

    {truck.permit, truck}
  end
end
