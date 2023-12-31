defmodule Ctrlv.Repo.Migrations.CreatePastes do
  use Ecto.Migration

  def change do
    create table(:pastes) do
      add :puid, :string, null: false
      add :content_sha, :string, null: false
      add :content, :text, null: false
      add :language, :string, null: false
      add :expires_at, :utc_datetime
      timestamps(updated_at: false)
    end

    create unique_index(:pastes, [:puid])
    create unique_index(:pastes, [:content_sha])
  end
end
