defmodule WscliveWeb.InstantPeakLive.Show do
  use WscliveWeb, :live_view

  alias Wsclive.Records

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:instant_peak, Records.get_instant_peak!(id))}
  end

  defp page_title(:show), do: "Show Instant peak"
  defp page_title(:edit), do: "Edit Instant peak"
end
