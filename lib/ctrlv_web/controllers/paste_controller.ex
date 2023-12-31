defmodule CtrlvWeb.PasteController do
  use CtrlvWeb, :controller

  alias Ctrlv.Pastes
  alias CtrlvWeb.Endpoint

  action_fallback CtrlvWeb.FallbackController

  @doc """
  Create a paste with paste params and return JSON response.
  """
  def create(conn, paste_params) do
    with {:ok, paste} <- Pastes.create_paste(paste_params) do
      conn
      |> put_status(:created)
      |> json(%{
        puid: paste.puid,
        link: link_for(paste),
        expires_at: paste.expires_at
      })
    end
  end

  defp link_for(paste) do
    Endpoint.url() <> ~p"/#{paste.puid}"
  end
end
