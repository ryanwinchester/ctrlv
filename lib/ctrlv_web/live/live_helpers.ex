defmodule CtrlvWeb.LiveHelpers do
  use CtrlvWeb, :live_component

  alias Phoenix.LiveView.JS

  @doc """
  Renders a live component inside a modal.

  The rendered modal receives a `:return_to` option to properly update
  the URL when the modal is closed.

  ## Examples

      <.modal return_to={Routes.paste_index_path(@socket, :index)}>
        <.live_component
          module={CtrlvWeb.PasteLive.FormComponent}
          id={@paste.id || :new}
          title={@page_title}
          action={@live_action}
          return_to={Routes.paste_index_path(@socket, :index)}
          paste: @paste
        />
      </.modal>
  """
  def modal(assigns) do
    assigns = assign_new(assigns, :return_to, fn -> nil end)

    ~H"""
    <div id="modal" class="phx-modal fade-in" phx-remove={hide_modal()}>
      <div
        id="modal-content"
        class="phx-modal-content fade-in-scale"
        phx-click-away={JS.dispatch("click", to: "#close")}
        phx-window-keydown={JS.dispatch("click", to: "#close")}
        phx-key="escape"
      >
        <.link
          :if={@return_to}
          patch={@return_to}
          id="close"
          class="phx-modal-close"
          phx-click={hide_modal()}
        >
          ✖
        </.link>

        <a :if={!@return_to} id="close" href="#" class="phx-modal-close" phx-click={hide_modal()}>
          ✖
        </a>

        <%= render_slot(@inner_block) %>
      </div>
    </div>
    """
  end

  defp hide_modal(js \\ %JS{}) do
    js
    |> JS.hide(to: "#modal", transition: "fade-out")
    |> JS.hide(to: "#modal-content", transition: "fade-out-scale")
  end
end
