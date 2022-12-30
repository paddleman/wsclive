defmodule Wsclive.Records do
  @moduledoc """
  The Records context.
  """

  import Ecto.Query, warn: false

  alias Wsclive.WscRepo
  alias Wsclive.Records.InstantPeak
  alias Wsclive.Stations.Station

  @doc """
  Returns the list of instant_peaks.

  ## Examples

      iex> list_instant_peaks()
      [%InstantPeak{}, ...]

  """
  def list_instant_peaks_for_station(station_id) do
    InstantPeak
    |> where([i], i.station_id == ^station_id)
    |> where([i], i.data_type == "Q" and i.peak_code == "H")
    |> select([i], {i.year, i.peak})
    |> WscRepo.all()
  end

  @doc """
  Gets a single instant_peak.

  Raises `Ecto.NoResultsError` if the Instant peak does not exist.

  ## Examples

      iex> get_instant_peak!(123)
      %InstantPeak{}

      iex> get_instant_peak!(456)
      ** (Ecto.NoResultsError)

  """
  def get_instant_peak!(id), do: WscRepo.get!(InstantPeak, id)

  @doc """
  Creates a instant_peak.

  ## Examples

      iex> create_instant_peak(%{field: value})
      {:ok, %InstantPeak{}}

      iex> create_instant_peak(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_instant_peak(attrs \\ %{}) do
    %InstantPeak{}
    |> InstantPeak.changeset(attrs)
    |> WscRepo.insert()
  end

  @doc """
  Updates a instant_peak.

  ## Examples

      iex> update_instant_peak(instant_peak, %{field: new_value})
      {:ok, %InstantPeak{}}

      iex> update_instant_peak(instant_peak, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_instant_peak(%InstantPeak{} = instant_peak, attrs) do
    instant_peak
    |> InstantPeak.changeset(attrs)
    |> WscRepo.update()
  end

  @doc """
  Deletes a instant_peak.

  ## Examples

      iex> delete_instant_peak(instant_peak)
      {:ok, %InstantPeak{}}

      iex> delete_instant_peak(instant_peak)
      {:error, %Ecto.Changeset{}}

  """
  def delete_instant_peak(%InstantPeak{} = instant_peak) do
    WscRepo.delete(instant_peak)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking instant_peak changes.

  ## Examples

      iex> change_instant_peak(instant_peak)
      %Ecto.Changeset{data: %InstantPeak{}}

  """
  def change_instant_peak(%InstantPeak{} = instant_peak, attrs \\ %{}) do
    InstantPeak.changeset(instant_peak, attrs)
  end
end
