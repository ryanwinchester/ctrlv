defmodule CtrlvWeb.PasteLive.Index do
  use CtrlvWeb, :live_view

  alias Ctrlv.Pastes
  alias Ctrlv.Pastes.Paste

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Paste")
    |> assign(:paste, Pastes.get_paste!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Paste")
    |> assign(:paste, %Paste{})
  end

  defp apply_action(socket, :index, _params) do
    push_redirect(socket, to: Routes.paste_new_path(socket, :new))
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    paste = Pastes.get_paste!(id)
    {:ok, _} = Pastes.delete_paste(paste)

    {:noreply, assign(socket, :pastes, list_pastes())}
  end

  defp list_pastes do
    Pastes.list_pastes()
  end
end
