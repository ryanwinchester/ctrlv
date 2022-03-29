defmodule CtrlvWeb.PageLive do
  use CtrlvWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, push_redirect(socket, to: Routes.paste_editor_path(socket, :new))}
  end

  @impl true
  def render(assigns), do: ~H""
end
