defmodule CounterWeb.PageLiveTest do
  use FoodtrucksWeb.ConnCase
  import Phoenix.LiveViewTest

  test "disconnected and connected render", %{conn: conn} do
    {:ok, page_live, disconnected_html} = live(conn, "/")
    assert disconnected_html =~ "Food Trucks"
    assert render(page_live) =~ "Food Trucks"
  end
end
