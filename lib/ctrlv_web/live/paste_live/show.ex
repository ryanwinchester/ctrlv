defmodule CtrlvWeb.PasteLive.Show do
  use CtrlvWeb, :live_view

  alias Ctrlv.Pastes
  alias Ctrlv.Pastes.Paste

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _session, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:paste, Pastes.get_paste!(id))}
  end

  defp page_title(:show), do: "Show Paste"
  defp page_title(:edit), do: "Edit Paste"
end
