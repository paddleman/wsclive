defmodule WscliveWeb.InstantPeakLive.FormComponent do
  use WscliveWeb, :live_component

  alias Wsclive.Records

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage instant_peak records in your database.</:subtitle>
      </.header>

      <.simple_form
        :let={f}
        for={@changeset}
        id="instant_peak-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={{f, :station_number}} type="text" label="station_number" />
        <.input field={{f, :data_type}} type="text" label="data_type" />
        <.input field={{f, :year}} type="number" label="year" />
        <.input field={{f, :peak_code}} type="text" label="peak_code" />
        <.input field={{f, :precision_code}} type="text" label="precision_code" />
        <.input field={{f, :month}} type="number" label="month" />
        <.input field={{f, :day}} type="number" label="day" />
        <.input field={{f, :hour}} type="number" label="hour" />
        <.input field={{f, :minute}} type="number" label="minute" />
        <.input field={{f, :time_zone}} type="text" label="time_zone" />
        <.input field={{f, :peak}} type="number" label="peak" step="any" />
        <.input field={{f, :symbol}} type="text" label="symbol" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Instant peak</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{instant_peak: instant_peak} = assigns, socket) do
    changeset = Records.change_instant_peak(instant_peak)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"instant_peak" => instant_peak_params}, socket) do
    changeset =
      socket.assigns.instant_peak
      |> Records.change_instant_peak(instant_peak_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"instant_peak" => instant_peak_params}, socket) do
    save_instant_peak(socket, socket.assigns.action, instant_peak_params)
  end

  defp save_instant_peak(socket, :edit, instant_peak_params) do
    case Records.update_instant_peak(socket.assigns.instant_peak, instant_peak_params) do
      {:ok, _instant_peak} ->
        {:noreply,
         socket
         |> put_flash(:info, "Instant peak updated successfully")
         |> push_navigate(to: socket.assigns.navigate)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_instant_peak(socket, :new, instant_peak_params) do
    case Records.create_instant_peak(instant_peak_params) do
      {:ok, _instant_peak} ->
        {:noreply,
         socket
         |> put_flash(:info, "Instant peak created successfully")
         |> push_navigate(to: socket.assigns.navigate)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
