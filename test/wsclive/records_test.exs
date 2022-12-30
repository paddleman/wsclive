defmodule Wsclive.RecordsTest do
  use Wsclive.DataCase

  alias Wsclive.Records

  describe "instant_peaks" do
    alias Wsclive.Records.InstantPeak

    import Wsclive.RecordsFixtures

    @invalid_attrs %{data_type: nil, day: nil, hour: nil, minute: nil, month: nil, peak: nil, peak_code: nil, precision_code: nil, station_number: nil, symbol: nil, time_zone: nil, year: nil}

    test "list_instant_peaks/0 returns all instant_peaks" do
      instant_peak = instant_peak_fixture()
      assert Records.list_instant_peaks() == [instant_peak]
    end

    test "get_instant_peak!/1 returns the instant_peak with given id" do
      instant_peak = instant_peak_fixture()
      assert Records.get_instant_peak!(instant_peak.id) == instant_peak
    end

    test "create_instant_peak/1 with valid data creates a instant_peak" do
      valid_attrs = %{data_type: "some data_type", day: 42, hour: 42, minute: 42, month: 42, peak: 120.5, peak_code: "some peak_code", precision_code: "some precision_code", station_number: "some station_number", symbol: "some symbol", time_zone: "some time_zone", year: 42}

      assert {:ok, %InstantPeak{} = instant_peak} = Records.create_instant_peak(valid_attrs)
      assert instant_peak.data_type == "some data_type"
      assert instant_peak.day == 42
      assert instant_peak.hour == 42
      assert instant_peak.minute == 42
      assert instant_peak.month == 42
      assert instant_peak.peak == 120.5
      assert instant_peak.peak_code == "some peak_code"
      assert instant_peak.precision_code == "some precision_code"
      assert instant_peak.station_number == "some station_number"
      assert instant_peak.symbol == "some symbol"
      assert instant_peak.time_zone == "some time_zone"
      assert instant_peak.year == 42
    end

    test "create_instant_peak/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Records.create_instant_peak(@invalid_attrs)
    end

    test "update_instant_peak/2 with valid data updates the instant_peak" do
      instant_peak = instant_peak_fixture()
      update_attrs = %{data_type: "some updated data_type", day: 43, hour: 43, minute: 43, month: 43, peak: 456.7, peak_code: "some updated peak_code", precision_code: "some updated precision_code", station_number: "some updated station_number", symbol: "some updated symbol", time_zone: "some updated time_zone", year: 43}

      assert {:ok, %InstantPeak{} = instant_peak} = Records.update_instant_peak(instant_peak, update_attrs)
      assert instant_peak.data_type == "some updated data_type"
      assert instant_peak.day == 43
      assert instant_peak.hour == 43
      assert instant_peak.minute == 43
      assert instant_peak.month == 43
      assert instant_peak.peak == 456.7
      assert instant_peak.peak_code == "some updated peak_code"
      assert instant_peak.precision_code == "some updated precision_code"
      assert instant_peak.station_number == "some updated station_number"
      assert instant_peak.symbol == "some updated symbol"
      assert instant_peak.time_zone == "some updated time_zone"
      assert instant_peak.year == 43
    end

    test "update_instant_peak/2 with invalid data returns error changeset" do
      instant_peak = instant_peak_fixture()
      assert {:error, %Ecto.Changeset{}} = Records.update_instant_peak(instant_peak, @invalid_attrs)
      assert instant_peak == Records.get_instant_peak!(instant_peak.id)
    end

    test "delete_instant_peak/1 deletes the instant_peak" do
      instant_peak = instant_peak_fixture()
      assert {:ok, %InstantPeak{}} = Records.delete_instant_peak(instant_peak)
      assert_raise Ecto.NoResultsError, fn -> Records.get_instant_peak!(instant_peak.id) end
    end

    test "change_instant_peak/1 returns a instant_peak changeset" do
      instant_peak = instant_peak_fixture()
      assert %Ecto.Changeset{} = Records.change_instant_peak(instant_peak)
    end
  end
end
