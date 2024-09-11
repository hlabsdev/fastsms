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

  describe "scheduled_smses" do
    alias Fastsms.Messaging.ScheduledSMS

    import Fastsms.MessagingFixtures

    @invalid_attrs %{message: nil, scheduled_at: nil, recurrence: nil}

    test "list_scheduled_smses/0 returns all scheduled_smses" do
      scheduled_sms = scheduled_sms_fixture()
      assert Messaging.list_scheduled_smses() == [scheduled_sms]
    end

    test "get_scheduled_sms!/1 returns the scheduled_sms with given id" do
      scheduled_sms = scheduled_sms_fixture()
      assert Messaging.get_scheduled_sms!(scheduled_sms.id) == scheduled_sms
    end

    test "create_scheduled_sms/1 with valid data creates a scheduled_sms" do
      valid_attrs = %{message: "some message", scheduled_at: ~U[2024-09-10 05:12:00Z], recurrence: "some recurrence"}

      assert {:ok, %ScheduledSMS{} = scheduled_sms} = Messaging.create_scheduled_sms(valid_attrs)
      assert scheduled_sms.message == "some message"
      assert scheduled_sms.scheduled_at == ~U[2024-09-10 05:12:00Z]
      assert scheduled_sms.recurrence == "some recurrence"
    end

    test "create_scheduled_sms/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Messaging.create_scheduled_sms(@invalid_attrs)
    end

    test "update_scheduled_sms/2 with valid data updates the scheduled_sms" do
      scheduled_sms = scheduled_sms_fixture()
      update_attrs = %{message: "some updated message", scheduled_at: ~U[2024-09-11 05:12:00Z], recurrence: "some updated recurrence"}

      assert {:ok, %ScheduledSMS{} = scheduled_sms} = Messaging.update_scheduled_sms(scheduled_sms, update_attrs)
      assert scheduled_sms.message == "some updated message"
      assert scheduled_sms.scheduled_at == ~U[2024-09-11 05:12:00Z]
      assert scheduled_sms.recurrence == "some updated recurrence"
    end

    test "update_scheduled_sms/2 with invalid data returns error changeset" do
      scheduled_sms = scheduled_sms_fixture()
      assert {:error, %Ecto.Changeset{}} = Messaging.update_scheduled_sms(scheduled_sms, @invalid_attrs)
      assert scheduled_sms == Messaging.get_scheduled_sms!(scheduled_sms.id)
    end

    test "delete_scheduled_sms/1 deletes the scheduled_sms" do
      scheduled_sms = scheduled_sms_fixture()
      assert {:ok, %ScheduledSMS{}} = Messaging.delete_scheduled_sms(scheduled_sms)
      assert_raise Ecto.NoResultsError, fn -> Messaging.get_scheduled_sms!(scheduled_sms.id) end
    end

    test "change_scheduled_sms/1 returns a scheduled_sms changeset" do
      scheduled_sms = scheduled_sms_fixture()
      assert %Ecto.Changeset{} = Messaging.change_scheduled_sms(scheduled_sms)
    end
  end

  describe "api_configurations" do
    alias Fastsms.Messaging.APIConfiguration

    import Fastsms.MessagingFixtures

    @invalid_attrs %{default: nil, api_key: nil, api_name: nil}

    test "list_api_configurations/0 returns all api_configurations" do
      api_configuration = api_configuration_fixture()
      assert Messaging.list_api_configurations() == [api_configuration]
    end

    test "get_api_configuration!/1 returns the api_configuration with given id" do
      api_configuration = api_configuration_fixture()
      assert Messaging.get_api_configuration!(api_configuration.id) == api_configuration
    end

    test "create_api_configuration/1 with valid data creates a api_configuration" do
      valid_attrs = %{default: true, api_key: "some api_key", api_name: "some api_name"}

      assert {:ok, %APIConfiguration{} = api_configuration} = Messaging.create_api_configuration(valid_attrs)
      assert api_configuration.default == true
      assert api_configuration.api_key == "some api_key"
      assert api_configuration.api_name == "some api_name"
    end

    test "create_api_configuration/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Messaging.create_api_configuration(@invalid_attrs)
    end

    test "update_api_configuration/2 with valid data updates the api_configuration" do
      api_configuration = api_configuration_fixture()
      update_attrs = %{default: false, api_key: "some updated api_key", api_name: "some updated api_name"}

      assert {:ok, %APIConfiguration{} = api_configuration} = Messaging.update_api_configuration(api_configuration, update_attrs)
      assert api_configuration.default == false
      assert api_configuration.api_key == "some updated api_key"
      assert api_configuration.api_name == "some updated api_name"
    end

    test "update_api_configuration/2 with invalid data returns error changeset" do
      api_configuration = api_configuration_fixture()
      assert {:error, %Ecto.Changeset{}} = Messaging.update_api_configuration(api_configuration, @invalid_attrs)
      assert api_configuration == Messaging.get_api_configuration!(api_configuration.id)
    end

    test "delete_api_configuration/1 deletes the api_configuration" do
      api_configuration = api_configuration_fixture()
      assert {:ok, %APIConfiguration{}} = Messaging.delete_api_configuration(api_configuration)
      assert_raise Ecto.NoResultsError, fn -> Messaging.get_api_configuration!(api_configuration.id) end
    end

    test "change_api_configuration/1 returns a api_configuration changeset" do
      api_configuration = api_configuration_fixture()
      assert %Ecto.Changeset{} = Messaging.change_api_configuration(api_configuration)
    end
  end

  describe "contacts" do
    alias Fastsms.Messaging.ContactLive

    import Fastsms.MessagingFixtures

    @invalid_attrs %{address: nil, first_name: nil, last_name: nil, phone_number: nil, email: nil}

    test "list_contacts/0 returns all contacts" do
      contact_live = contact_live_fixture()
      assert Messaging.list_contacts() == [contact_live]
    end

    test "get_contact_live!/1 returns the contact_live with given id" do
      contact_live = contact_live_fixture()
      assert Messaging.get_contact_live!(contact_live.id) == contact_live
    end

    test "create_contact_live/1 with valid data creates a contact_live" do
      valid_attrs = %{address: "some address", first_name: "some first_name", last_name: "some last_name", phone_number: "some phone_number", email: "some email"}

      assert {:ok, %ContactLive{} = contact_live} = Messaging.create_contact_live(valid_attrs)
      assert contact_live.address == "some address"
      assert contact_live.first_name == "some first_name"
      assert contact_live.last_name == "some last_name"
      assert contact_live.phone_number == "some phone_number"
      assert contact_live.email == "some email"
    end

    test "create_contact_live/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Messaging.create_contact_live(@invalid_attrs)
    end

    test "update_contact_live/2 with valid data updates the contact_live" do
      contact_live = contact_live_fixture()
      update_attrs = %{address: "some updated address", first_name: "some updated first_name", last_name: "some updated last_name", phone_number: "some updated phone_number", email: "some updated email"}

      assert {:ok, %ContactLive{} = contact_live} = Messaging.update_contact_live(contact_live, update_attrs)
      assert contact_live.address == "some updated address"
      assert contact_live.first_name == "some updated first_name"
      assert contact_live.last_name == "some updated last_name"
      assert contact_live.phone_number == "some updated phone_number"
      assert contact_live.email == "some updated email"
    end

    test "update_contact_live/2 with invalid data returns error changeset" do
      contact_live = contact_live_fixture()
      assert {:error, %Ecto.Changeset{}} = Messaging.update_contact_live(contact_live, @invalid_attrs)
      assert contact_live == Messaging.get_contact_live!(contact_live.id)
    end

    test "delete_contact_live/1 deletes the contact_live" do
      contact_live = contact_live_fixture()
      assert {:ok, %ContactLive{}} = Messaging.delete_contact_live(contact_live)
      assert_raise Ecto.NoResultsError, fn -> Messaging.get_contact_live!(contact_live.id) end
    end

    test "change_contact_live/1 returns a contact_live changeset" do
      contact_live = contact_live_fixture()
      assert %Ecto.Changeset{} = Messaging.change_contact_live(contact_live)
    end
  end
end
