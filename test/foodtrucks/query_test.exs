defmodule Foodtrucks.QueryTest do
  use ExUnit.Case

  alias Foodtrucks.Query

  test "it correctly translates day of week to string version" do
    assert Query.day_of_week_to_string(1) == "Monday"
    assert Query.day_of_week_to_string(2) == "Tuesday"
    assert Query.day_of_week_to_string(3) == "Wednesday"
    assert Query.day_of_week_to_string(4) == "Thursday"
    assert Query.day_of_week_to_string(5) == "Friday"
    assert Query.day_of_week_to_string(6) == "Saturday"
    assert Query.day_of_week_to_string(7) == "Sunday"
  end
end
