defmodule CtrlvWeb.PasteJSON do
  @moduledoc false
  use CtrlvWeb, :verified_routes

  alias Ctrlv.Pastes.Paste
  alias CtrlvWeb.Endpoint

  @doc """
  The response when paste was created.
  """
  def created(%Paste{puid: puid}) do
    %{puid: puid, url: url_for(puid)}
  end

  defp url_for(puid), do: Endpoint.url() <> ~p"/#{puid}"
end
