defmodule CtrlvWeb.PasteLive.Index do
  use CtrlvWeb, :live_view

  alias Ctrlv.Pastes

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :is_editing, false)}
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

  defp apply_action(socket, :index, _params) do
    push_redirect(socket, to: Routes.paste_new_path(socket, :new))
  end
end
