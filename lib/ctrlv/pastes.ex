defmodule Ctrlv.Pastes do
  @moduledoc """
  The Pastes context.
  """

  import Ecto.Query, warn: false

  alias Ecto.Changeset

  alias Ctrlv.CodeImage
  alias Ctrlv.Pastes.Paste
  alias Ctrlv.Repo

  @doc """
  Returns the list of pastes.

  ## Examples

      iex> list_pastes()
      [%Paste{}, ...]

  """
  def list_pastes do
    Repo.all(Paste)
  end

  @doc """
  Gets a single paste.

  Raises `Ecto.NoResultsError` if the Paste does not exist.

  ## Examples

      iex> get_paste!(123)
      %Paste{}

      iex> get_paste!(456)
      ** (Ecto.NoResultsError)

  """
  def get_paste!(id), do: Repo.get!(Paste, id)

  @doc """
  Gets a single paste by keyword.

  Raises `Ecto.NoResultsError` if the Paste does not exist.

  ## Examples

      iex> get_paste_by!(puid: "abc123")
      %Paste{}

      iex> get_paste_by!(puid: "notexists")
      ** (Ecto.NoResultsError)

  """
  def get_paste_by!(by), do: Repo.get_by!(Paste, by)

  @doc """
  Gets a single paste by PUID (if it is not expired).

  Raises `Ecto.NoResultsError` if the Paste does not exist.

  ## Examples

      iex> get_active_paste_by_puid!("abc123")
      %Paste{}

      iex> get_active_paste_by_puid!("notexists")
      ** (Ecto.NoResultsError)

  """
  def get_active_paste_by_puid!(puid) do
    Repo.one!(
      from p in Paste,
        where: p.puid == ^puid,
        where: p.expires_at > ^DateTime.utc_now()
    )
  end

  @doc """
  Creates a paste.

  ## Examples

      iex> create_paste(%{field: value})
      {:ok, %Paste{}}

      iex> create_paste(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_paste(%Changeset{} = changeset) do
    Repo.transact(fn ->
      with {:ok, paste} <- Repo.insert(changeset),
           image <- CodeImage.from_paste(paste),
           {:ok, path} <- CodeImage.upload(paste.pid, image) do
        update_paste(paste, %{image_path: path})
      end
    end)
  end

  def create_paste(attrs) do
    %Paste{}
    |> Paste.changeset(attrs)
    |> create_paste()
  end

  @doc """
  Updates a paste.

  ## Examples

      iex> update_paste(paste, %{field: new_value})
      {:ok, %Paste{}}

      iex> update_paste(paste, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_paste(%Paste{} = paste, attrs) do
    paste
    |> Paste.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a paste.

  ## Examples

      iex> delete_paste(paste)
      {:ok, %Paste{}}

      iex> delete_paste(paste)
      {:error, %Ecto.Changeset{}}

  """
  def delete_paste(%Paste{} = paste) do
    Repo.delete(paste)
  end

  @doc """
  Deletes all of the pastes that are expired.
  """
  def delete_all_expired_pastes do
    Repo.delete_all(
      from p in Paste,
        where: p.expires_at <= ^DateTime.utc_now()
    )
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking paste changes.

  ## Examples

      iex> change_paste(paste)
      %Ecto.Changeset{data: %Paste{}}

  """
  def change_paste(paste, attrs \\ %{}) do
    Paste.changeset(paste, attrs)
  end
end
