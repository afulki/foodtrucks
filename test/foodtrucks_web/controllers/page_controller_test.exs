defmodule FoodtrucksWeb.PageControllerTest do
  use FoodtrucksWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Local Food Trucks"
  end
end
