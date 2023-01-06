defmodule Foodtrucks.Sources.SanFranciscoFoodTruckApi do
  import Exsoda.Reader

  alias Foodtrucks.Truck

  def get_the_data() do
    with {:ok, stream} <- query("jjew-r69b", domain: "data.sfgov.org") |> run do
      stream
      |> Enum.map(&parse_truck/1)
    end
  end

  defp parse_truck(truck) do
    truck = truck 
      |> Truck.new() 
    {truck.permit, truck}
  end
end
