defmodule Foodtrucks.DayOfWeek do
  @moduledoc """
  Utilitiy functions to deal with day of week translation
  """
  def as_string(1), do: "Monday"
  def as_string(2), do: "Tuesday"
  def as_string(3), do: "Wednesday"
  def as_string(4), do: "Thursday"
  def as_string(5), do: "Friday"
  def as_string(6), do: "Saturday"
  def as_string(7), do: "Sunday"

  def date_to_day_string(date \\ Date.utc_today()) do
    date
    |> Date.day_of_week()
    |> as_string()
  end
end
