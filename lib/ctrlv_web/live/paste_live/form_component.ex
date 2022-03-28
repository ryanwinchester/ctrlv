defmodule CtrlvWeb.PasteLive.FormComponent do
  use CtrlvWeb, :live_component

  alias Ctrlv.Pastes

  @impl true
  def update(%{paste: paste} = assigns, socket) do
    changeset = Pastes.change_paste(paste)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"paste" => paste_params}, socket) do
    changeset =
      socket.assigns.paste
      |> Pastes.change_paste(paste_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"paste" => paste_params}, socket) do
    save_paste(socket, socket.assigns.action, paste_params)
  end

  defp save_paste(socket, :edit, paste_params) do
    case Pastes.update_paste(socket.assigns.paste, paste_params) do
      {:ok, _paste} ->
        {:noreply,
         socket
         |> put_flash(:info, "Paste updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_paste(socket, :new, paste_params) do
    case Pastes.create_paste(paste_params) do
      {:ok, _paste} ->
        {:noreply,
         socket
         |> put_flash(:info, "Paste created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
