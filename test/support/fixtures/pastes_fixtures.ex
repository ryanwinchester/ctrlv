defmodule Ctrlv.PastesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Ctrlv.Pastes` context.
  """

  @doc """
  Generate a paste.
  """
  def paste_fixture(attrs \\ %{}) do
    {:ok, paste} =
      attrs
      |> Enum.into(%{
        content: "some content",
        expires_at: ~U[2022-03-27 03:02:00Z],
        puid: "some puid"
      })
      |> Ctrlv.Pastes.create_paste()

    paste
  end
end
