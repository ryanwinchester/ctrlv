defmodule CtrlvWeb.PasteLive.Editor do
  use CtrlvWeb, :live_view

  alias Ctrlv.Pastes
  alias Ctrlv.Pastes.Paste
  alias CtrlvWeb.PasteLive.SideBarComponent

  require Logger

  # ----------------------------------------------------------------------------
  # LiveView Callbacks
  # ----------------------------------------------------------------------------

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  @impl true
  def handle_event("editor-created", _params, socket) do
    doc = socket.assigns[:paste] && List.first(socket.assigns.paste.content)
    language = socket.assigns[:paste] && socket.assigns.paste.language
    {:reply, %{doc: doc, language: language}, socket}
  end

  def handle_event("form-change", %{"paste" => paste_attrs}, socket) do
    changeset = Pastes.change_paste(%Paste{}, paste_attrs)
    language = changeset.changes.language

    {:noreply,
     socket
     |> assign(:changeset, changeset)
     |> push_event("switch-language", %{language: language})}
  end

  def handle_event("init-save", _params, socket) do
    Logger.debug("[PasteLive.Editor] initiating save...")
    {:noreply, push_event(socket, "init-save-paste", %{})}
  end

  def handle_event("save-paste", %{"doc" => doc}, socket) do
    changeset = Pastes.change_paste(socket.assigns.changeset, %{content: [doc]})

    case Pastes.create_paste(changeset) do
      {:ok, paste} ->
        {:noreply,
         socket
         |> put_flash(:success, "created paste")
         |> push_redirect(to: Routes.paste_editor_path(socket, :show, paste.puid))}

      {:error, changeset} ->
        Logger.debug(inspect(changeset))
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  # ----------------------------------------------------------------------------
  # Helpers
  # ----------------------------------------------------------------------------

  defp apply_action(socket, :new, params) do
    paste = params["puid"] && Pastes.get_active_paste_by_puid!(params["puid"])

    socket
    |> assign(:page_title, "New Paste")
    |> assign(:is_editing, true)
    |> assign(:paste, paste)
    |> assign(:changeset, changeset(:new, paste))
  end

  defp apply_action(socket, :show, %{"puid" => puid}) do
    socket
    |> assign(:page_title, "View Paste")
    |> assign(:is_editing, false)
    |> assign(:changeset, nil)
    |> assign(:paste, Pastes.get_active_paste_by_puid!(puid))
  end

  defp changeset(:new, %Paste{} = paste) do
    paste
    |> Map.take([:content, :language])
    |> Map.put(:expires_in, "1_day")
    |> then(&Pastes.change_paste(%Paste{}, &1))
  end

  defp changeset(:new, nil) do
    Pastes.change_paste(%Paste{}, %{language: :javascript, expires_in: "1_day"})
  end
end
