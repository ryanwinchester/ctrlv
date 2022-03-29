defmodule Ctrlv.Pastes.Paste do
  @moduledoc false
  use Ctrlv.Schema

  import Ecto.Changeset

  alias Ctrlv.Pastes.PUID

  @supported_languages [
    :cpp,
    :css,
    :html,
    :java,
    :javascript,
    :json,
    :markdown,
    :php,
    :python,
    :rust
  ]

  schema "pastes" do
    field :puid, :string
    field :content_sha, :string
    field :content, :string
    field :language, Ecto.Enum, values: @supported_languages
    field :expires_at, :utc_datetime

    field :expires_in, Ecto.Enum, values: [:"10_minutes", :"1_hour", :"1_day", :"3_days", :"1_week", :"1_month"], virtual: true

    timestamps()
  end

  @doc false
  def changeset(paste, attrs) do
    paste
    |> cast(attrs, [:content, :expires_in, :language])
    |> validate_required([:content, :expires_in, :language])
    |> put_expires_at()
    |> put_puid()
    |> put_sha()
    |> unique_constraint(:content_sha, message: "duplicate content")
  end

  def put_expires_at(changeset) do
    case get_change(changeset, :expires_in) do
      nil ->
        changeset

      expires_in ->
        seconds = expires_in_to_seconds(expires_in)
        expires_at = DateTime.utc_now() |> DateTime.add(seconds, :second)
        put_change(changeset, :expires_at, expires_at)
    end
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

  # Get the amount of seconds from now that it expires at.
  defp expires_in_to_seconds(:"10_minutes"), do: 600
  defp expires_in_to_seconds(:"1_hour"), do: 86400
  defp expires_in_to_seconds(:"1_day"), do: 86400
  defp expires_in_to_seconds(:"3_days"), do: 259200
  defp expires_in_to_seconds(:"1_week"), do: 604800
  defp expires_in_to_seconds(:"1_month"), do: 2628000
end
