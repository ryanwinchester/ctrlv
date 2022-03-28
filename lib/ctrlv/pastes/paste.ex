defmodule Ctrlv.Pastes.Paste do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "pastes" do
    field :content, :string
    field :expires_at, :utc_datetime
    field :puid, :string

    timestamps()
  end

  @doc false
  def changeset(paste, attrs) do
    paste
    |> cast(attrs, [:puid, :content, :expires_at])
    |> validate_required([:puid, :content, :expires_at])
  end
end
