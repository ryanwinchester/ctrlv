defmodule Ctrlv.Pastes.Paste do
  @moduledoc false
  use Ctrlv.Schema

  import Ecto.Changeset

  alias Ctrlv.Pastes.PUID

  schema "pastes" do
    field :puid, :string
    field :content_sha, :string
    field :content, :string
    field :expires_at, :utc_datetime

    timestamps()
  end

  @doc false
  def changeset(paste, attrs) do
    paste
    |> cast(attrs, [:content, :expires_at])
    |> validate_required([:content, :expires_at])
    |> put_puid()
    |> put_sha()
    |> unique_constraint(:content_sha, message: "duplicate content")
  end

  # Add the PUID to the paste.
  defp put_puid(%{valid?: true} = changeset) do
    case get_field(changeset, :puid) do
      nil ->
        put_change(changeset, :puid, PUID.generate())

      _puid ->
        changeset
    end
  end

  # Only bother generating PUID if changeset is valid.
  defp put_puid(changeset), do: changeset

  # Add the content SHA.
  defp put_sha(%{valid?: true} = changeset) do
    case get_change(changeset, :content) do
      nil ->
        changeset

      content ->
        put_change(changeset, :content_sha, :crypto.hash(:sha256, content))
    end
  end

  # Only bother generating SHA if changeset is valid.
  defp put_sha(changeset), do: changeset
end
