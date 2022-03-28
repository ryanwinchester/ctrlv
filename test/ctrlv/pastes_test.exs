defmodule Ctrlv.PastesTest do
  use Ctrlv.DataCase

  alias Ctrlv.Pastes

  describe "pastes" do
    alias Ctrlv.Pastes.Paste

    import Ctrlv.PastesFixtures

    @invalid_attrs %{content: nil, expires_at: nil, puid: nil}

    test "list_pastes/0 returns all pastes" do
      paste = paste_fixture()
      assert Pastes.list_pastes() == [paste]
    end

    test "get_paste!/1 returns the paste with given id" do
      paste = paste_fixture()
      assert Pastes.get_paste!(paste.id) == paste
    end

    test "create_paste/1 with valid data creates a paste" do
      valid_attrs = %{content: "some content", expires_at: ~U[2022-03-27 03:02:00Z], puid: "some puid"}

      assert {:ok, %Paste{} = paste} = Pastes.create_paste(valid_attrs)
      assert paste.content == "some content"
      assert paste.expires_at == ~U[2022-03-27 03:02:00Z]
      assert paste.puid == "some puid"
    end

    test "create_paste/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Pastes.create_paste(@invalid_attrs)
    end

    test "update_paste/2 with valid data updates the paste" do
      paste = paste_fixture()
      update_attrs = %{content: "some updated content", expires_at: ~U[2022-03-28 03:02:00Z], puid: "some updated puid"}

      assert {:ok, %Paste{} = paste} = Pastes.update_paste(paste, update_attrs)
      assert paste.content == "some updated content"
      assert paste.expires_at == ~U[2022-03-28 03:02:00Z]
      assert paste.puid == "some updated puid"
    end

    test "update_paste/2 with invalid data returns error changeset" do
      paste = paste_fixture()
      assert {:error, %Ecto.Changeset{}} = Pastes.update_paste(paste, @invalid_attrs)
      assert paste == Pastes.get_paste!(paste.id)
    end

    test "delete_paste/1 deletes the paste" do
      paste = paste_fixture()
      assert {:ok, %Paste{}} = Pastes.delete_paste(paste)
      assert_raise Ecto.NoResultsError, fn -> Pastes.get_paste!(paste.id) end
    end

    test "change_paste/1 returns a paste changeset" do
      paste = paste_fixture()
      assert %Ecto.Changeset{} = Pastes.change_paste(paste)
    end
  end
end
