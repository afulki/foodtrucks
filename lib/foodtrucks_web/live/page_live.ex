defmodule FoodtrucksWeb.PageLive do
  use FoodtrucksWeb, :live_view

  alias Foodtrucks.{Truck, Query}

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket |> assign(number: 0)}
  end

  @impl true
  def handle_event("add_trucks_open_today", _params, socket) do
    new_socket = Query.open_today() 
      |> Enum.reduce(socket, fn truck, socket -> push_event(socket, "new_truck", %{truck: truck_to_map_data(truck)}) end)
    {:noreply, new_socket}
  end

  @impl true
  def handle_event("add_all_trucks", _params, socket) do
    new_socket = Query.all() 
      |> Enum.reduce(socket, fn truck, socket -> push_event(socket, "new_truck", %{truck: truck_to_map_data(truck)}) end)
    {:noreply, new_socket}
  end

  defp truck_to_map_data(%Truck{} = truck) do
    %{
      latitude: truck.latitude,
      longitude: truck.longitude,
      pin_color: truck.pin_color,
      title: truck.applicant,
      open_times: "#{truck.start24} to #{truck.end24}",
      optional_text: truck.optionaltext,
      day: truck.dayofweekstr
    }
  end
end
