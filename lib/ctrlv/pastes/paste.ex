defmodule Ctrlv.Pastes.Paste do
  @moduledoc false
  use Ctrlv.Schema

  import Ecto.Changeset

  alias Ctrlv.Pastes.Language
  alias Ctrlv.Pastes.PUID

  @type t :: %__MODULE__{
          id: String.t(),
          puid: String.t(),
          content_sha: String.t(),
          content: String.t(),
          language: atom(),
          image_path: String.t() | nil,
          expires_at: DateTime.t(),
          inserted_at: DateTime.t()
        }

  schema "pastes" do
    field :puid, :string
    field :content_sha, :string
    field :content, :string
    field :language, Ecto.Enum, values: Language.list()
    field :expires_at, :utc_datetime
    field :image_path, :string

    field :expires_in, Ecto.Enum,
      values: ~w(10_minutes 1_hour 1_day 3_days 1_week 1_month)a,
      redact: true,
      virtual: true

    timestamps(updated_at: false)
  end

  @doc """
  The valid `expires_in` values.
  """
  def expires_in_values do
    Ecto.Enum.dump_values(Ctrlv.Pastes.Paste, :expires_in)
  end

  @doc false
  def changeset(paste, attrs) do
    paste
    |> cast(attrs, [:content, :expires_in, :language, :image_path], message: &cast_error_message/2)
    |> validate_length(:content, greater_than_or_equal_to: 1)
    |> validate_required([:expires_in, :language])
    |> put_expires_at()
    |> put_puid()
    |> put_sha()
    |> unique_constraint(:content_sha, message: "duplicate content")
  end

  defp cast_error_message(:expires_in, _error_metadata) do
    "must be one of: " <> Enum.join(expires_in_values(), ", ")
  end

  defp cast_error_message(_field, _error_metadata), do: "is invalid"

  defp put_expires_at(changeset) do
    case get_change(changeset, :expires_in) do
      nil ->
        changeset

      expires_in ->
        expires_at = expires_in_to_seconds(expires_in) |> add_seconds_to_now()
        put_change(changeset, :expires_at, expires_at)
    end
  end

  defp put_puid(%{valid?: true} = changeset) do
    case get_field(changeset, :puid) do
      nil ->
        put_change(changeset, :puid, PUID.generate())

      _puid ->
        changeset
    end
  end

  defp put_puid(changeset), do: changeset

  defp put_sha(%{valid?: true} = changeset) do
    case get_change(changeset, :content) do
      nil ->
        changeset

      content ->
        hash = :crypto.hash(:sha256, content) |> Base.encode16()
        put_change(changeset, :content_sha, hash)
    end
  end

  defp put_sha(changeset), do: changeset

  defp expires_in_to_seconds(:"10_minutes"), do: 600
  defp expires_in_to_seconds(:"1_hour"), do: 86400
  defp expires_in_to_seconds(:"1_day"), do: 86400
  defp expires_in_to_seconds(:"3_days"), do: 259_200
  defp expires_in_to_seconds(:"1_week"), do: 604_800
  defp expires_in_to_seconds(:"1_month"), do: 2_628_000

  defp add_seconds_to_now(seconds) do
    DateTime.utc_now()
    |> DateTime.add(seconds, :second)
    |> DateTime.truncate(:second)
  end
end
