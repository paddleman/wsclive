defmodule WscliveWeb.StationLive.Index do
  use WscliveWeb, :live_view

  alias Wsclive.Stations
  alias Wsclive.Stations.Station

  @impl true
  def mount(_params, _session, socket) do
    socket
    |> assign(stations: list_stations())
    |> assign(selected_station: nil)

    {:ok, socket}
  end

  def handle_event("get-stations", _, socket) do
    {:reply, %{stations: socket.assigns.stations}, socket}
  end

  def handle_event("marker-clicked", station_id, socket) do
    station = find_station(socket, station_id)

    {:reply, %{station: station}, assign(socket, selected_station: station)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Station")
    |> assign(:station, Stations.get_station!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Station")
    |> assign(:station, %Station{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(stations: list_stations())
    |> assign(:page_title, "Listing Stations")
    |> assign(:selected_station, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    station = Stations.get_station!(id)
    {:ok, _} = Stations.delete_station(station)

    {:noreply, assign(socket, :stations, list_stations())}
  end

  defp list_stations do
    Stations.list_stations()
  end

  defp find_station(socket, id) do
    Enum.find(socket.assigns.stations, &(&1.id == id))
  end
end
