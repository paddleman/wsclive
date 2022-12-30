defmodule Wsclive.RecordsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Wsclive.Records` context.
  """

  @doc """
  Generate a instant_peak.
  """
  def instant_peak_fixture(attrs \\ %{}) do
    {:ok, instant_peak} =
      attrs
      |> Enum.into(%{
        data_type: "some data_type",
        day: 42,
        hour: 42,
        minute: 42,
        month: 42,
        peak: 120.5,
        peak_code: "some peak_code",
        precision_code: "some precision_code",
        station_number: "some station_number",
        symbol: "some symbol",
        time_zone: "some time_zone",
        year: 42
      })
      |> Wsclive.Records.create_instant_peak()

    instant_peak
  end
end
