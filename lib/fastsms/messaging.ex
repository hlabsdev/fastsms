defmodule Fastsms.Messaging do
  @moduledoc """
  The Messaging context.
  """

  import Ecto.Query, warn: false
  alias Fastsms.Repo

  alias Fastsms.Messaging.Contact

  @doc """
  Returns the list of contacts.

  ## Examples

      iex> list_contacts()
      [%Contact{}, ...]

  """
  def list_contacts do
    Repo.all(Contact)
  end

  def list_contacts(contact_ids) when is_list(contact_ids) do
    Repo.all(Contact, id: contact_ids)
  end

  @doc """
  Gets a single contact.

  Raises `Ecto.NoResultsError` if the Contact does not exist.

  ## Examples

      iex> get_contact!(123)
      %Contact{}

      iex> get_contact!(456)
      ** (Ecto.NoResultsError)

  """
  def get_contact!(id) do
    Repo.get!(Contact, id)
    |> Repo.preload(:groups)
    |> Repo.preload(:smses)
  end

  @doc """
  Creates a contact.

  ## Examples

      iex> create_contact(%{field: value})
      {:ok, %Contact{}}

      iex> create_contact(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_contact(attrs \\ %{}) do
    %Contact{}
    |> Contact.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a contact.

  ## Examples

      iex> update_contact(contact, %{field: new_value})
      {:ok, %Contact{}}

      iex> update_contact(contact, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_contact(%Contact{} = contact, attrs) do
    contact
    |> Contact.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a contact.

  ## Examples

      iex> delete_contact(contact)
      {:ok, %Contact{}}

      iex> delete_contact(contact)
      {:error, %Ecto.Changeset{}}

  """
  def delete_contact(%Contact{} = contact) do
    Repo.delete(contact)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking contact changes.

  ## Examples

      iex> change_contact(contact)
      %Ecto.Changeset{data: %Contact{}}

  """
  def change_contact(%Contact{} = contact, attrs \\ %{}) do
    Contact.changeset(contact, attrs)
  end

  alias Fastsms.Messaging.Group

  @doc """
  Returns the list of groups.

  ## Examples

      iex> list_groups()
      [%Group{}, ...]

  """
  def list_groups do
    Repo.all(Group)
  end

  def list_groups(group_ids) when is_list(group_ids) do
    Repo.all(Group, id: group_ids)
  end
  @doc """
  Gets a single group.

  Raises `Ecto.NoResultsError` if the Group does not exist.

  ## Examples

      iex> get_group!(123)
      %Group{}

      iex> get_group!(456)
      ** (Ecto.NoResultsError)

  """
  def get_group!(id) do
    Group
    |> Repo.get!(id)
    |> Repo.preload(:contacts)  # Précharge les contacts
    |> Repo.preload(:scheduled_smses)
  end

  @doc """
  Creates a group.

  ## Examples

      iex> create_group(%{field: value})
      {:ok, %Group{}}

      iex> create_group(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_group(attrs \\ %{}) do
    %Group{}
    |> Group.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a group.

  ## Examples

      iex> update_group(group, %{field: new_value})
      {:ok, %Group{}}

      iex> update_group(group, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_group(%Group{} = group, attrs) do
    group
    |> Group.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a group.

  ## Examples

      iex> delete_group(group)
      {:ok, %Group{}}

      iex> delete_group(group)
      {:error, %Ecto.Changeset{}}

  """
  def delete_group(%Group{} = group) do
    Repo.delete(group)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking group changes.

  ## Examples

      iex> change_group(group)
      %Ecto.Changeset{data: %Group{}}

  """
  def change_group(%Group{} = group, attrs \\ %{}) do
    Group.changeset(group, attrs)
  end

  alias Fastsms.Messaging.GroupContact

  def add_contacts_to_group(group_id, contact_ids) do
    contacts = Enum.map(contact_ids, fn contact_id ->
      %{
        group_id: group_id,
        contact_id: String.to_integer(contact_id),
#        inserted_at: DateTime.utc_now(),
#        updated_at: DateTime.utc_now()
      }
    end)
    Repo.insert_all(GroupContact, contacts)
#    contact_ids
#    |> Enum.map(&%GroupContact{group_id: group_id, contact_id: &1})
#    |> Repo.insert_all(GroupContact)
  end

  def remove_contacts_from_group(group_id, contact_ids) do
    from(gc in GroupContact, where: gc.group_id == ^group_id and gc.contact_id in ^contact_ids)
    |> Repo.delete_all()
  end

  def create_group_with_contacts(attrs, contact_ids) do
    Repo.transaction(fn ->
      {:ok, group} = create_group(attrs)
      add_contacts_to_group(group.id, contact_ids)
      group
    end)
  end

  # Method qui enleve tout peut importe si c'est ancien ou pas (Pas optimale)
#  def update_group_with_contact(group_id, new_contact_ids) do
#    Repo.transaction(fn ->
#      # Remove existing contacts
#      from(gc in GroupContact, where: gc.group_id == ^group_id)
#      |> Repo.delete_all()
#
#      # Add new contacts
#      add_contacts_to_group(group_id, new_contact_ids)
#    end)
#  end

  # This check the existing contacts before the operation
  def update_group_with_contact(group_id, new_contact_ids) do
    Repo.transaction(fn ->
      # Fetch existing contacts
      existing_contacts = from(gc in GroupContact, where: gc.group_id == ^group_id, select: gc.contact_id)
                          |> Repo.all()

      # Determine contacts to remove and add
      contacts_to_remove = existing_contacts -- new_contact_ids
      contacts_to_add = new_contact_ids -- existing_contacts


      # Remove contacts using the existing function
      remove_contacts_from_group(group_id, contacts_to_remove)

      # Add new contacts
      add_contacts_to_group(group_id, contacts_to_add)
    end)
  end
  alias Fastsms.Messaging.SMS

  @doc """
  Returns the list of smses.

  ## Examples

      iex> list_smses()
      [%SMS{}, ...]

  """
  def list_smses do
    Repo.all(SMS)
  end

  @doc """
  Gets a single sms.

  Raises `Ecto.NoResultsError` if the Sms does not exist.

  ## Examples

      iex> get_sms!(123)
      %SMS{}

      iex> get_sms!(456)
      ** (Ecto.NoResultsError)

  """
  def get_sms!(id) do
    Repo.get!(SMS, id)
    |> Repo.preload(:contact)
  end

  @doc """
  Creates a sms.

  ## Examples

      iex> create_sms(%{field: value})
      {:ok, %SMS{}}

      iex> create_sms(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_sms(attrs \\ %{}) do
    %SMS{}
    |> SMS.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a sms.

  ## Examples

      iex> update_sms(sms, %{field: new_value})
      {:ok, %SMS{}}

      iex> update_sms(sms, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_sms(%SMS{} = sms, attrs) do
    sms
    |> SMS.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a sms.

  ## Examples

      iex> delete_sms(sms)
      {:ok, %SMS{}}

      iex> delete_sms(sms)
      {:error, %Ecto.Changeset{}}

  """
  def delete_sms(%SMS{} = sms) do
    Repo.delete(sms)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking sms changes.

  ## Examples

      iex> change_sms(sms)
      %Ecto.Changeset{data: %SMS{}}

  """
  def change_sms(%SMS{} = sms, attrs \\ %{}) do
    SMS.changeset(sms, attrs)
  end

  alias Fastsms.Messaging.ScheduledSMS

  @doc """
  Returns the list of scheduled_smses.

  ## Examples

      iex> list_scheduled_smses()
      [%ScheduledSMS{}, ...]

  """
  def list_scheduled_smses do
    Repo.all(ScheduledSMS)
  end

  @doc """
  Gets a single scheduled_sms.

  Raises `Ecto.NoResultsError` if the Scheduled sms does not exist.

  ## Examples

      iex> get_scheduled_sms!(123)
      %ScheduledSMS{}

      iex> get_scheduled_sms!(456)
      ** (Ecto.NoResultsError)

  """
  def get_scheduled_sms!(id) do
    Repo.get!(ScheduledSMS, id)
    |> Repo.preload(:contact)
    |> Repo.preload(:group)
  end

  @doc """
  Creates a scheduled_sms.

  ## Examples

      iex> create_scheduled_sms(%{field: value})
      {:ok, %ScheduledSMS{}}

      iex> create_scheduled_sms(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_scheduled_sms(attrs \\ %{}) do
    %ScheduledSMS{}
    |> ScheduledSMS.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a scheduled_sms.

  ## Examples

      iex> update_scheduled_sms(scheduled_sms, %{field: new_value})
      {:ok, %ScheduledSMS{}}

      iex> update_scheduled_sms(scheduled_sms, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_scheduled_sms(%ScheduledSMS{} = scheduled_sms, attrs) do
    scheduled_sms
    |> ScheduledSMS.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a scheduled_sms.

  ## Examples

      iex> delete_scheduled_sms(scheduled_sms)
      {:ok, %ScheduledSMS{}}

      iex> delete_scheduled_sms(scheduled_sms)
      {:error, %Ecto.Changeset{}}

  """
  def delete_scheduled_sms(%ScheduledSMS{} = scheduled_sms) do
    Repo.delete(scheduled_sms)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking scheduled_sms changes.

  ## Examples

      iex> change_scheduled_sms(scheduled_sms)
      %Ecto.Changeset{data: %ScheduledSMS{}}

  """
  def change_scheduled_sms(%ScheduledSMS{} = scheduled_sms, attrs \\ %{}) do
    ScheduledSMS.changeset(scheduled_sms, attrs)
  end

  alias Fastsms.Messaging.APIConfiguration

  @doc """
  Returns the list of api_configurations.

  ## Examples

      iex> list_api_configurations()
      [%APIConfiguration{}, ...]

  """
  def list_api_configurations do
    Repo.all(APIConfiguration)
  end

  @doc """
  Gets a single api_configuration.

  Raises `Ecto.NoResultsError` if the Api configuration does not exist.

  ## Examples

      iex> get_api_configuration!(123)
      %APIConfiguration{}

      iex> get_api_configuration!(456)
      ** (Ecto.NoResultsError)

  """
  def get_api_configuration!(id), do: Repo.get!(APIConfiguration, id)

  @doc """
  Creates a api_configuration.

  ## Examples

      iex> create_api_configuration(%{field: value})
      {:ok, %APIConfiguration{}}

      iex> create_api_configuration(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_api_configuration(attrs \\ %{}) do
    %APIConfiguration{}
    |> APIConfiguration.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a api_configuration.

  ## Examples

      iex> update_api_configuration(api_configuration, %{field: new_value})
      {:ok, %APIConfiguration{}}

      iex> update_api_configuration(api_configuration, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_api_configuration(%APIConfiguration{} = api_configuration, attrs) do
    api_configuration
    |> APIConfiguration.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a api_configuration.

  ## Examples

      iex> delete_api_configuration(api_configuration)
      {:ok, %APIConfiguration{}}

      iex> delete_api_configuration(api_configuration)
      {:error, %Ecto.Changeset{}}

  """
  def delete_api_configuration(%APIConfiguration{} = api_configuration) do
    Repo.delete(api_configuration)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking api_configuration changes.

  ## Examples

      iex> change_api_configuration(api_configuration)
      %Ecto.Changeset{data: %APIConfiguration{}}

  """
  def change_api_configuration(%APIConfiguration{} = api_configuration, attrs \\ %{}) do
    APIConfiguration.changeset(api_configuration, attrs)
  end

  alias Fastsms.Messaging.GroupContact

  @doc """
  Returns the list of group_contacts.

  ## Examples

      iex> list_group_contacts()
      [%GroupContact{}, ...]

  """
  def list_group_contacts do
    Repo.all(GroupContact)
  end

  @doc """
  Gets a single group_contact.

  Raises `Ecto.NoResultsError` if the Group contact does not exist.

  ## Examples

      iex> get_group_contact!(123)
      %GroupContact{}

      iex> get_group_contact!(456)
      ** (Ecto.NoResultsError)

  """
  def get_group_contact!(id) do
    Repo.get!(GroupContact, id)
    |> Repo.preload(:group)
    |> Repo.preload(:contact)
  end

  @doc """
  Creates a group_contact.

  ## Examples

      iex> create_group_contact(%{field: value})
      {:ok, %GroupContact{}}

      iex> create_group_contact(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_group_contact(attrs \\ %{}) do
    %GroupContact{}
    |> GroupContact.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a group_contact.

  ## Examples

      iex> update_group_contact(group_contact, %{field: new_value})
      {:ok, %GroupContact{}}

      iex> update_group_contact(group_contact, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_group_contact(%GroupContact{} = group_contact, attrs) do
    group_contact
    |> GroupContact.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a group_contact.

  ## Examples

      iex> delete_group_contact(group_contact)
      {:ok, %GroupContact{}}

      iex> delete_group_contact(group_contact)
      {:error, %Ecto.Changeset{}}

  """
  def delete_group_contact(%GroupContact{} = group_contact) do
    Repo.delete(group_contact)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking group_contact changes.

  ## Examples

      iex> change_group_contact(group_contact)
      %Ecto.Changeset{data: %GroupContact{}}

  """
  def change_group_contact(%GroupContact{} = group_contact, attrs \\ %{}) do
    GroupContact.changeset(group_contact, attrs)
  end
end
