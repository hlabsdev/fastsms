defmodule Fastsms.MessagingTest do
  use Fastsms.DataCase

  alias Fastsms.Messaging

  describe "contacts" do
    alias Fastsms.Messaging.Contact

    import Fastsms.MessagingFixtures

    @invalid_attrs %{address: nil, email: nil, first_name: nil, last_name: nil, phone_number: nil}

    test "list_contacts/0 returns all contacts" do
      contact = contact_fixture()
      assert Messaging.list_contacts() == [contact]
    end

    test "get_contact!/1 returns the contact with given id" do
      contact = contact_fixture()
      assert Messaging.get_contact!(contact.id) == contact
    end

    test "create_contact/1 with valid data creates a contact" do
      valid_attrs = %{address: "some address", email: "some email", first_name: "some first_name", last_name: "some last_name", phone_number: "some phone_number"}

      assert {:ok, %Contact{} = contact} = Messaging.create_contact(valid_attrs)
      assert contact.address == "some address"
      assert contact.email == "some email"
      assert contact.first_name == "some first_name"
      assert contact.last_name == "some last_name"
      assert contact.phone_number == "some phone_number"
    end

    test "create_contact/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Messaging.create_contact(@invalid_attrs)
    end

    test "update_contact/2 with valid data updates the contact" do
      contact = contact_fixture()
      update_attrs = %{address: "some updated address", email: "some updated email", first_name: "some updated first_name", last_name: "some updated last_name", phone_number: "some updated phone_number"}

      assert {:ok, %Contact{} = contact} = Messaging.update_contact(contact, update_attrs)
      assert contact.address == "some updated address"
      assert contact.email == "some updated email"
      assert contact.first_name == "some updated first_name"
      assert contact.last_name == "some updated last_name"
      assert contact.phone_number == "some updated phone_number"
    end

    test "update_contact/2 with invalid data returns error changeset" do
      contact = contact_fixture()
      assert {:error, %Ecto.Changeset{}} = Messaging.update_contact(contact, @invalid_attrs)
      assert contact == Messaging.get_contact!(contact.id)
    end

    test "delete_contact/1 deletes the contact" do
      contact = contact_fixture()
      assert {:ok, %Contact{}} = Messaging.delete_contact(contact)
      assert_raise Ecto.NoResultsError, fn -> Messaging.get_contact!(contact.id) end
    end

    test "change_contact/1 returns a contact changeset" do
      contact = contact_fixture()
      assert %Ecto.Changeset{} = Messaging.change_contact(contact)
    end
  end

  describe "groups" do
    alias Fastsms.Messaging.Group

    import Fastsms.MessagingFixtures

    @invalid_attrs %{name: nil}

    test "list_groups/0 returns all groups" do
      group = group_fixture()
      assert Messaging.list_groups() == [group]
    end

    test "get_group!/1 returns the group with given id" do
      group = group_fixture()
      assert Messaging.get_group!(group.id) == group
    end

    test "create_group/1 with valid data creates a group" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Group{} = group} = Messaging.create_group(valid_attrs)
      assert group.name == "some name"
    end

    test "create_group/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Messaging.create_group(@invalid_attrs)
    end

    test "update_group/2 with valid data updates the group" do
      group = group_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Group{} = group} = Messaging.update_group(group, update_attrs)
      assert group.name == "some updated name"
    end

    test "update_group/2 with invalid data returns error changeset" do
      group = group_fixture()
      assert {:error, %Ecto.Changeset{}} = Messaging.update_group(group, @invalid_attrs)
      assert group == Messaging.get_group!(group.id)
    end

    test "delete_group/1 deletes the group" do
      group = group_fixture()
      assert {:ok, %Group{}} = Messaging.delete_group(group)
      assert_raise Ecto.NoResultsError, fn -> Messaging.get_group!(group.id) end
    end

    test "change_group/1 returns a group changeset" do
      group = group_fixture()
      assert %Ecto.Changeset{} = Messaging.change_group(group)
    end
  end

  describe "smses" do
    alias Fastsms.Messaging.SMS

    import Fastsms.MessagingFixtures

    @invalid_attrs %{message: nil, status: nil, sent_at: nil, dynamic_fields: nil}

    test "list_smses/0 returns all smses" do
      sms = sms_fixture()
      assert Messaging.list_smses() == [sms]
    end

    test "get_sms!/1 returns the sms with given id" do
      sms = sms_fixture()
      assert Messaging.get_sms!(sms.id) == sms
    end

    test "create_sms/1 with valid data creates a sms" do
      valid_attrs = %{message: "some message", status: "some status", sent_at: ~U[2024-09-10 05:10:00Z], dynamic_fields: %{}}

      assert {:ok, %SMS{} = sms} = Messaging.create_sms(valid_attrs)
      assert sms.message == "some message"
      assert sms.status == "some status"
      assert sms.sent_at == ~U[2024-09-10 05:10:00Z]
      assert sms.dynamic_fields == %{}
    end

    test "create_sms/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Messaging.create_sms(@invalid_attrs)
    end

    test "update_sms/2 with valid data updates the sms" do
      sms = sms_fixture()
      update_attrs = %{message: "some updated message", status: "some updated status", sent_at: ~U[2024-09-11 05:10:00Z], dynamic_fields: %{}}

      assert {:ok, %SMS{} = sms} = Messaging.update_sms(sms, update_attrs)
      assert sms.message == "some updated message"
      assert sms.status == "some updated status"
      assert sms.sent_at == ~U[2024-09-11 05:10:00Z]
      assert sms.dynamic_fields == %{}
    end

    test "update_sms/2 with invalid data returns error changeset" do
      sms = sms_fixture()
      assert {:error, %Ecto.Changeset{}} = Messaging.update_sms(sms, @invalid_attrs)
      assert sms == Messaging.get_sms!(sms.id)
    end

    test "delete_sms/1 deletes the sms" do
      sms = sms_fixture()
      assert {:ok, %SMS{}} = Messaging.delete_sms(sms)
      assert_raise Ecto.NoResultsError, fn -> Messaging.get_sms!(sms.id) end
    end

    test "change_sms/1 returns a sms changeset" do
      sms = sms_fixture()
      assert %Ecto.Changeset{} = Messaging.change_sms(sms)
    end
  end
end
