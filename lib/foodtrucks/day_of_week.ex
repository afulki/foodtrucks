defmodule Foodtrucks.DayOfWeek do
  @moduledoc """
  Utilitiy functions to deal with day of week translation
  """

  @doc """
  Convert a weekday numeber to a string, formatted in the same way as 
  the dayofweekstr supplied by the API.

  ## Examples

    iex> Foodtrucks.DayOfWeek.as_string(2)
    "Tuesday"

  """
  def as_string(1), do: "Monday"
  def as_string(2), do: "Tuesday"
  def as_string(3), do: "Wednesday"
  def as_string(4), do: "Thursday"
  def as_string(5), do: "Friday"
  def as_string(6), do: "Saturday"
  def as_string(7), do: "Sunday"

  @doc """
  Return the day string for a given date, if no date given it defaults to today.

  ## Examples

    iex> Foodtrucks.DayOfWeek.date_to_day_string(Date.new!(2023,1,1))
    "Sunday"

  """
  def date_to_day_string(date \\ Date.utc_today()) do
    date
    |> Date.day_of_week()
    |> as_string()
  end
end
