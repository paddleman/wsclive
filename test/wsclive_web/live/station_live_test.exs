defmodule WscliveWeb.StationLiveTest do
  use WscliveWeb.ConnCase

  import Phoenix.LiveViewTest
  import Wsclive.StationsFixtures

  @create_attrs %{drainage_area_effect: 120.5, drainage_area_gross: 120.5, hyd_status: "some hyd_status", latitude: 120.5, longitude: 120.5, prov: "some prov", sed_status: "some sed_status", station_name: "some station_name", station_number: "some station_number"}
  @update_attrs %{drainage_area_effect: 456.7, drainage_area_gross: 456.7, hyd_status: "some updated hyd_status", latitude: 456.7, longitude: 456.7, prov: "some updated prov", sed_status: "some updated sed_status", station_name: "some updated station_name", station_number: "some updated station_number"}
  @invalid_attrs %{drainage_area_effect: nil, drainage_area_gross: nil, hyd_status: nil, latitude: nil, longitude: nil, prov: nil, sed_status: nil, station_name: nil, station_number: nil}

  defp create_station(_) do
    station = station_fixture()
    %{station: station}
  end

  describe "Index" do
    setup [:create_station]

    test "lists all stations", %{conn: conn, station: station} do
      {:ok, _index_live, html} = live(conn, ~p"/stations")

      assert html =~ "Listing Stations"
      assert html =~ station.hyd_status
    end

    test "saves new station", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/stations")

      assert index_live |> element("a", "New Station") |> render_click() =~
               "New Station"

      assert_patch(index_live, ~p"/stations/new")

      assert index_live
             |> form("#station-form", station: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#station-form", station: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, ~p"/stations")

      assert html =~ "Station created successfully"
      assert html =~ "some hyd_status"
    end

    test "updates station in listing", %{conn: conn, station: station} do
      {:ok, index_live, _html} = live(conn, ~p"/stations")

      assert index_live |> element("#stations-#{station.id} a", "Edit") |> render_click() =~
               "Edit Station"

      assert_patch(index_live, ~p"/stations/#{station}/edit")

      assert index_live
             |> form("#station-form", station: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#station-form", station: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, ~p"/stations")

      assert html =~ "Station updated successfully"
      assert html =~ "some updated hyd_status"
    end

    test "deletes station in listing", %{conn: conn, station: station} do
      {:ok, index_live, _html} = live(conn, ~p"/stations")

      assert index_live |> element("#stations-#{station.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#station-#{station.id}")
    end
  end

  describe "Show" do
    setup [:create_station]

    test "displays station", %{conn: conn, station: station} do
      {:ok, _show_live, html} = live(conn, ~p"/stations/#{station}")

      assert html =~ "Show Station"
      assert html =~ station.hyd_status
    end

    test "updates station within modal", %{conn: conn, station: station} do
      {:ok, show_live, _html} = live(conn, ~p"/stations/#{station}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Station"

      assert_patch(show_live, ~p"/stations/#{station}/show/edit")

      assert show_live
             |> form("#station-form", station: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#station-form", station: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, ~p"/stations/#{station}")

      assert html =~ "Station updated successfully"
      assert html =~ "some updated hyd_status"
    end
  end
end
