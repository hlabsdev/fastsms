defmodule FastsmsWeb.ContactLiveTest do
  use FastsmsWeb.ConnCase

  import Phoenix.LiveViewTest
  import Fastsms.MessagingFixtures

  @create_attrs %{address: "some address", first_name: "some first_name", last_name: "some last_name", phone_number: "some phone_number", email: "some email"}
  @update_attrs %{address: "some updated address", first_name: "some updated first_name", last_name: "some updated last_name", phone_number: "some updated phone_number", email: "some updated email"}
  @invalid_attrs %{address: nil, first_name: nil, last_name: nil, phone_number: nil, email: nil}

  defp create_contact(_) do
    contact = contact_fixture()
    %{contact: contact}
  end

  describe "Index" do
    setup [:create_contact]

    test "lists all contacts", %{conn: conn, contact: contact} do
      {:ok, _index_live, html} = live(conn, ~p"/contacts")

      assert html =~ "Listing Contacts"
      assert html =~ contact.address
    end

    test "saves new contact", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/contacts")

      assert index_live |> element("a", "New Contact") |> render_click() =~
               "New Contact"

      assert_patch(index_live, ~p"/contacts/new")

      assert index_live
             |> form("#contact-form", contact: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#contact-form", contact: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/contacts")

      html = render(index_live)
      assert html =~ "Contact created successfully"
      assert html =~ "some address"
    end

    test "updates contact in listing", %{conn: conn, contact: contact} do
      {:ok, index_live, _html} = live(conn, ~p"/contacts")

      assert index_live |> element("#contacts-#{contact.id} a", "Edit") |> render_click() =~
               "Edit Contact"

      assert_patch(index_live, ~p"/contacts/#{contact}/edit")

      assert index_live
             |> form("#contact-form", contact: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#contact-form", contact: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/contacts")

      html = render(index_live)
      assert html =~ "Contact updated successfully"
      assert html =~ "some updated address"
    end

    test "deletes contact in listing", %{conn: conn, contact: contact} do
      {:ok, index_live, _html} = live(conn, ~p"/contacts")

      assert index_live |> element("#contacts-#{contact.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#contacts-#{contact.id}")
    end
  end

  describe "Show" do
    setup [:create_contact]

    test "displays contact", %{conn: conn, contact: contact} do
      {:ok, _show_live, html} = live(conn, ~p"/contacts/#{contact}")

      assert html =~ "Show Contact"
      assert html =~ contact.address
    end

    test "updates contact within modal", %{conn: conn, contact: contact} do
      {:ok, show_live, _html} = live(conn, ~p"/contacts/#{contact}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Contact"

      assert_patch(show_live, ~p"/contacts/#{contact}/show/edit")

      assert show_live
             |> form("#contact-form", contact: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#contact-form", contact: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/contacts/#{contact}")

      html = render(show_live)
      assert html =~ "Contact updated successfully"
      assert html =~ "some updated address"
    end
  end
end
