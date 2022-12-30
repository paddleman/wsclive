defmodule WscliveWeb.InstantPeakLive.Index do
  use WscliveWeb, :live_view

  alias Wsclive.Records
  alias Wsclive.Records.InstantPeak

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :instant_peaks, list_instant_peaks())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Instant peak")
    |> assign(:instant_peak, Records.get_instant_peak!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Instant peak")
    |> assign(:instant_peak, %InstantPeak{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Instant peaks")
    |> assign(:instant_peak, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    instant_peak = Records.get_instant_peak!(id)
    {:ok, _} = Records.delete_instant_peak(instant_peak)

    {:noreply, assign(socket, :instant_peaks, list_instant_peaks())}
  end

  defp list_instant_peaks do
    Records.list_instant_peaks()
  end
end
