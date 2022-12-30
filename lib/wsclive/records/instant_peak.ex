defmodule Wsclive.Records.InstantPeak do
  use Ecto.Schema
  import Ecto.Changeset

  alias Wsclive.Stations

  schema "annual_instant_peaks" do
    # can be flow ("Q") or stage ("H")
    field :data_type, :string

    # flow informtion
    field :peak, :float
    field :peak_code, :string
    field :precision_code, :string
    field :symbol, :string

    # time information
    field :year, :integer
    field :month, :integer
    field :day, :integer
    field :hour, :integer
    field :minute, :integer
    field :time_zone, :string

    field :station_number, :string
    # field :station_id, :id

    belongs_to :station, Stations.Station

    # timestamps()
  end

  @doc false
  def changeset(instant_peak, attrs) do
    instant_peak
    |> cast(attrs, [
      :station_number,
      :data_type,
      :year,
      :peak_code,
      :precision_code,
      :month,
      :day,
      :hour,
      :minute,
      :time_zone,
      :peak,
      :symbol
    ])
    |> validate_required([:station_number, :peak, :station_id])
  end
end
