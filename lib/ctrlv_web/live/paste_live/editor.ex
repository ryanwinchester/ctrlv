defmodule CtrlvWeb.PasteLive.Editor do
  use CtrlvWeb, :live_view

  alias Ctrlv.Pastes
  alias Ctrlv.Pastes.Paste
  alias CtrlvWeb.PasteLive.BottomMenuComponent
  alias CtrlvWeb.PasteLive.SideMenuComponent

  require Logger

  @default_language "javascript"

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
  def handle_event("form-change", %{"paste" => paste_attrs}, socket) do
    changeset = Pastes.change_paste(%Paste{}, paste_attrs)
    language = changeset.changes.language

    {:noreply,
     socket
     |> LiveMonacoEditor.change_language(to_string(language))
     |> assign(:changeset, changeset)}
  end

  def handle_event("save-paste", _params, socket) do
    changeset = Pastes.change_paste(socket.assigns.changeset, %{content: socket.assigns.content})

    case Pastes.create_paste(changeset) do
      {:ok, paste} ->
        {:noreply,
         socket
         |> put_flash(:success, "created paste")
         |> push_navigate(to: ~p"/#{paste.puid}")}

      {:error, changeset} ->
        Logger.debug(inspect(changeset))
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  # ignore change events from the editor field
  def handle_event("validate", %{"_target" => ["live_monaco_editor", "my_file.html"]}, socket) do
    {:noreply, socket}
  end

  def handle_event("set_editor_value", %{"value" => value}, socket) do
    {:noreply, assign(socket, :content, value)}
  end

  # ----------------------------------------------------------------------------
  # Helpers
  # ----------------------------------------------------------------------------

  defp apply_action(socket, :new, params) do
    paste = params["puid"] && Pastes.get_active_paste_by_puid!(params["puid"])
    language = if paste, do: to_string(paste.language), else: @default_language
    editor_opts = editor_opts(%{"language" => language, "readOnly" => false})

    socket
    |> assign(:page_title, "New Paste")
    |> assign(:is_editing, true)
    |> assign(:paste, paste)
    |> assign(:editor_opts, editor_opts)
    |> assign(:changeset, changeset(:new, paste))
  end

  defp apply_action(socket, :show, %{"puid" => puid}) do
    paste = Pastes.get_active_paste_by_puid!(puid)
    editor_opts = editor_opts(%{"language" => to_string(paste.language), "readOnly" => true})

    socket
    |> assign(:page_title, "View Paste")
    |> assign(:is_editing, false)
    |> assign(:editor_opts, editor_opts)
    |> assign(:changeset, nil)
    |> assign(:paste, paste)
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

  defp editor_opts(opts) do
    Map.merge(LiveMonacoEditor.default_opts(), opts)
  end
end
