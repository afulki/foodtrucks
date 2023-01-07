defmodule Foodtrucks.DayOfWeekTest do
  use ExUnit.Case

  alias Foodtrucks.DayOfWeek

  test "it correctly translates day of week to string version" do
    assert DayOfWeek.as_string(1) == "Monday"
    assert DayOfWeek.as_string(2) == "Tuesday"
    assert DayOfWeek.as_string(3) == "Wednesday"
    assert DayOfWeek.as_string(4) == "Thursday"
    assert DayOfWeek.as_string(5) == "Friday"
    assert DayOfWeek.as_string(6) == "Saturday"
    assert DayOfWeek.as_string(7) == "Sunday"
  end

  test "it returns the correct string for the given date" do
    assert DayOfWeek.date_to_day_string(Date.new!(2023, 1, 1)) == "Sunday"
    assert DayOfWeek.date_to_day_string(Date.new!(2023, 6, 28)) == "Wednesday"
  end
end
