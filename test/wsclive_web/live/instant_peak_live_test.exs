defmodule WscliveWeb.InstantPeakLiveTest do
  use WscliveWeb.ConnCase

  import Phoenix.LiveViewTest
  import Wsclive.RecordsFixtures

  @create_attrs %{data_type: "some data_type", day: 42, hour: 42, minute: 42, month: 42, peak: 120.5, peak_code: "some peak_code", precision_code: "some precision_code", station_number: "some station_number", symbol: "some symbol", time_zone: "some time_zone", year: 42}
  @update_attrs %{data_type: "some updated data_type", day: 43, hour: 43, minute: 43, month: 43, peak: 456.7, peak_code: "some updated peak_code", precision_code: "some updated precision_code", station_number: "some updated station_number", symbol: "some updated symbol", time_zone: "some updated time_zone", year: 43}
  @invalid_attrs %{data_type: nil, day: nil, hour: nil, minute: nil, month: nil, peak: nil, peak_code: nil, precision_code: nil, station_number: nil, symbol: nil, time_zone: nil, year: nil}

  defp create_instant_peak(_) do
    instant_peak = instant_peak_fixture()
    %{instant_peak: instant_peak}
  end

  describe "Index" do
    setup [:create_instant_peak]

    test "lists all instant_peaks", %{conn: conn, instant_peak: instant_peak} do
      {:ok, _index_live, html} = live(conn, ~p"/instant_peaks")

      assert html =~ "Listing Instant peaks"
      assert html =~ instant_peak.data_type
    end

    test "saves new instant_peak", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/instant_peaks")

      assert index_live |> element("a", "New Instant peak") |> render_click() =~
               "New Instant peak"

      assert_patch(index_live, ~p"/instant_peaks/new")

      assert index_live
             |> form("#instant_peak-form", instant_peak: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#instant_peak-form", instant_peak: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, ~p"/instant_peaks")

      assert html =~ "Instant peak created successfully"
      assert html =~ "some data_type"
    end

    test "updates instant_peak in listing", %{conn: conn, instant_peak: instant_peak} do
      {:ok, index_live, _html} = live(conn, ~p"/instant_peaks")

      assert index_live |> element("#instant_peaks-#{instant_peak.id} a", "Edit") |> render_click() =~
               "Edit Instant peak"

      assert_patch(index_live, ~p"/instant_peaks/#{instant_peak}/edit")

      assert index_live
             |> form("#instant_peak-form", instant_peak: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#instant_peak-form", instant_peak: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, ~p"/instant_peaks")

      assert html =~ "Instant peak updated successfully"
      assert html =~ "some updated data_type"
    end

    test "deletes instant_peak in listing", %{conn: conn, instant_peak: instant_peak} do
      {:ok, index_live, _html} = live(conn, ~p"/instant_peaks")

      assert index_live |> element("#instant_peaks-#{instant_peak.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#instant_peak-#{instant_peak.id}")
    end
  end

  describe "Show" do
    setup [:create_instant_peak]

    test "displays instant_peak", %{conn: conn, instant_peak: instant_peak} do
      {:ok, _show_live, html} = live(conn, ~p"/instant_peaks/#{instant_peak}")

      assert html =~ "Show Instant peak"
      assert html =~ instant_peak.data_type
    end

    test "updates instant_peak within modal", %{conn: conn, instant_peak: instant_peak} do
      {:ok, show_live, _html} = live(conn, ~p"/instant_peaks/#{instant_peak}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Instant peak"

      assert_patch(show_live, ~p"/instant_peaks/#{instant_peak}/show/edit")

      assert show_live
             |> form("#instant_peak-form", instant_peak: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#instant_peak-form", instant_peak: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, ~p"/instant_peaks/#{instant_peak}")

      assert html =~ "Instant peak updated successfully"
      assert html =~ "some updated data_type"
    end
  end
end
