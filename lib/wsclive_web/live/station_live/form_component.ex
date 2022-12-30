defmodule WscliveWeb.StationLive.FormComponent do
  use WscliveWeb, :live_component

  alias Wsclive.Stations

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage station records in your database.</:subtitle>
      </.header>

      <.simple_form
        :let={f}
        for={@changeset}
        id="station-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={{f, :station_number}} type="text" label="station_number" />
        <.input field={{f, :station_name}} type="text" label="station_name" />
        <.input field={{f, :hyd_status}} type="text" label="hyd_status" />
        <.input
          field={{f, :drainage_area_gross}}
          type="number"
          label="drainage_area_gross"
          step="any"
        />
        <.input
          field={{f, :drainage_area_effect}}
          type="number"
          label="drainage_area_effect"
          step="any"
        />

        <:actions>
          <.button phx-disable-with="Saving...">Save Station</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{station: station} = assigns, socket) do
    changeset = Stations.change_station(station)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"station" => station_params}, socket) do
    changeset =
      socket.assigns.station
      |> Stations.change_station(station_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"station" => station_params}, socket) do
    save_station(socket, socket.assigns.action, station_params)
  end

  defp save_station(socket, :edit, station_params) do
    case Stations.update_station(socket.assigns.station, station_params) do
      {:ok, _station} ->
        {:noreply,
         socket
         |> put_flash(:info, "Station updated successfully")
         |> push_navigate(to: socket.assigns.navigate)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_station(socket, :new, station_params) do
    case Stations.create_station(station_params) do
      {:ok, _station} ->
        {:noreply,
         socket
         |> put_flash(:info, "Station created successfully")
         |> push_navigate(to: socket.assigns.navigate)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
