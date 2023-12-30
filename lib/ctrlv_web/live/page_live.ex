defmodule CtrlvWeb.PageLive do
  use CtrlvWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, push_redirect(socket, to: ~p"/new")}
  end

  @impl true
  def render(assigns), do: ~H""
end
