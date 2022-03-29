defmodule CtrlvWeb.PasteLiveTest do
  use CtrlvWeb.ConnCase

  import Phoenix.LiveViewTest
  import Ctrlv.PastesFixtures

  @create_attrs %{
    content: "some content",
    expires_at: %{day: 27, hour: 3, minute: 2, month: 3, year: 2022},
    puid: "some puid"
  }
  @update_attrs %{
    content: "some updated content",
    expires_at: %{day: 28, hour: 3, minute: 2, month: 3, year: 2022},
    puid: "some updated puid"
  }
  @invalid_attrs %{
    content: nil,
    expires_at: %{day: 30, hour: 3, minute: 2, month: 2, year: 2022},
    puid: nil
  }

  defp create_paste(_) do
    paste = paste_fixture()
    %{paste: paste}
  end

  describe "Index" do
    setup [:create_paste]

    test "lists all pastes", %{conn: conn, paste: paste} do
      {:ok, _index_live, html} = live(conn, Routes.paste_index_path(conn, :index))

      assert html =~ "Listing Pastes"
      assert html =~ paste.content
    end

    test "saves new paste", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.paste_index_path(conn, :index))

      assert index_live |> element("a", "New Paste") |> render_click() =~
               "New Paste"

      assert_patch(index_live, Routes.paste_index_path(conn, :new))

      assert index_live
             |> form("#paste-form", paste: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        index_live
        |> form("#paste-form", paste: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.paste_index_path(conn, :index))

      assert html =~ "Paste created successfully"
      assert html =~ "some content"
    end

    test "updates paste in listing", %{conn: conn, paste: paste} do
      {:ok, index_live, _html} = live(conn, Routes.paste_index_path(conn, :index))

      assert index_live |> element("#paste-#{paste.id} a", "Edit") |> render_click() =~
               "Edit Paste"

      assert_patch(index_live, Routes.paste_index_path(conn, :edit, paste))

      assert index_live
             |> form("#paste-form", paste: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        index_live
        |> form("#paste-form", paste: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.paste_index_path(conn, :index))

      assert html =~ "Paste updated successfully"
      assert html =~ "some updated content"
    end

    test "deletes paste in listing", %{conn: conn, paste: paste} do
      {:ok, index_live, _html} = live(conn, Routes.paste_index_path(conn, :index))

      assert index_live |> element("#paste-#{paste.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#paste-#{paste.id}")
    end
  end

  describe "Show" do
    setup [:create_paste]

    test "displays paste", %{conn: conn, paste: paste} do
      {:ok, _show_live, html} = live(conn, Routes.paste_show_path(conn, :show, paste))

      assert html =~ "Show Paste"
      assert html =~ paste.content
    end

    test "updates paste within modal", %{conn: conn, paste: paste} do
      {:ok, show_live, _html} = live(conn, Routes.paste_show_path(conn, :show, paste))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Paste"

      assert_patch(show_live, Routes.paste_show_path(conn, :edit, paste))

      assert show_live
             |> form("#paste-form", paste: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        show_live
        |> form("#paste-form", paste: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.paste_show_path(conn, :show, paste))

      assert html =~ "Paste updated successfully"
      assert html =~ "some updated content"
    end
  end
end
