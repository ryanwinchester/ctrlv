defmodule CtrlvWeb.PasteLive.New do
  use CtrlvWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
      socket
      |> assign(:page_title, "New Paste")
      |> assign(:is_editing, true)}
  end
end
