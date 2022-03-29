defmodule CtrlvWeb.PasteLive.Editor do
  use CtrlvWeb, :live_view

  alias Ctrlv.Pastes
  alias Ctrlv.Pastes.Paste

  require Logger

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  @impl true
  def handle_event("form-change", %{"paste" => paste_attrs}, socket) do
    changeset = Pastes.change_paste(%Paste{content: "noop"}, paste_attrs)
    language = changeset.changes.language

    {:noreply,
      socket
      |> assign(:changeset, changeset)
      |> push_event("switch-language", %{language: language})}
  end

  def handle_event("save", _params, socket) do
    Logger.debug("[PasteLive.Editor] save...")
    # TODO: Get content from CM, and save.
    {:noreply, socket}
  end

  defp apply_action(socket, :new, params) do
    socket
    |> assign(:page_title, "New Paste")
    |> assign(:is_editing, true)
    |> assign(:changeset, changeset(:new, params))
  end

  defp apply_action(socket, :show, %{"puid" => puid}) do
    socket
    |> assign(:page_title, "View Paste")
    |> assign(:is_editing, false)
    |> assign(:changeset, nil)
    |> assign(:paste, Pastes.get_paste_by!(puid: puid))
  end

  defp changeset(:new, _params) do
    Pastes.change_paste(%Paste{content: "noop"}, %{language: :javascript})
  end
end
