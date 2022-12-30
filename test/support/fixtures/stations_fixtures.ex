defmodule Wsclive.StationsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Wsclive.Stations` context.
  """

  @doc """
  Generate a station.
  """
  def station_fixture(attrs \\ %{}) do
    {:ok, station} =
      attrs
      |> Enum.into(%{
        drainage_area_effect: 120.5,
        drainage_area_gross: 120.5,
        hyd_status: "some hyd_status",
        latitude: 120.5,
        longitude: 120.5,
        prov: "some prov",
        sed_status: "some sed_status",
        station_name: "some station_name",
        station_number: "some station_number"
      })
      |> Wsclive.Stations.create_station()

    station
  end
end
