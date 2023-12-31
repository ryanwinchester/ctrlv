defmodule CtrlvWeb.FallbackController do
  use CtrlvWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(json: CtrlvWeb.ErrorJSON)
    |> render("422.json", changeset: changeset)
  end

  # Catch-all for now.
  def call(conn, {:error, status}) when is_atom(status) do
    conn
    |> put_status(status)
    |> put_view(json: HelloWeb.ErrorJSON)
    |> render(:"#{Plug.Conn.Status.code(status)}")
  end
end
