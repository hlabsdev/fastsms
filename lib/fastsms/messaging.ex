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

  @doc """
  Gets a single contact.

  Raises `Ecto.NoResultsError` if the Contact does not exist.

  ## Examples

      iex> get_contact!(123)
      %Contact{}

      iex> get_contact!(456)
      ** (Ecto.NoResultsError)

  """
  def get_contact!(id), do: Repo.get!(Contact, id)

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

  @doc """
  Gets a single group.

  Raises `Ecto.NoResultsError` if the Group does not exist.

  ## Examples

      iex> get_group!(123)
      %Group{}

      iex> get_group!(456)
      ** (Ecto.NoResultsError)

  """
  def get_group!(id), do: Repo.get!(Group, id)

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
  def get_sms!(id), do: Repo.get!(SMS, id)

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
  def get_scheduled_sms!(id), do: Repo.get!(ScheduledSMS, id)

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

  alias Fastsms.Messaging.ContactLive

  @doc """
  Returns the list of contacts.

  ## Examples

      iex> list_contacts()
      [%ContactLive{}, ...]

  """
  def list_contacts do
    Repo.all(ContactLive)
  end

  @doc """
  Gets a single contact_live.

  Raises `Ecto.NoResultsError` if the Contact live does not exist.

  ## Examples

      iex> get_contact_live!(123)
      %ContactLive{}

      iex> get_contact_live!(456)
      ** (Ecto.NoResultsError)

  """
  def get_contact_live!(id), do: Repo.get!(ContactLive, id)

  @doc """
  Creates a contact_live.

  ## Examples

      iex> create_contact_live(%{field: value})
      {:ok, %ContactLive{}}

      iex> create_contact_live(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_contact_live(attrs \\ %{}) do
    %ContactLive{}
    |> ContactLive.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a contact_live.

  ## Examples

      iex> update_contact_live(contact_live, %{field: new_value})
      {:ok, %ContactLive{}}

      iex> update_contact_live(contact_live, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_contact_live(%ContactLive{} = contact_live, attrs) do
    contact_live
    |> ContactLive.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a contact_live.

  ## Examples

      iex> delete_contact_live(contact_live)
      {:ok, %ContactLive{}}

      iex> delete_contact_live(contact_live)
      {:error, %Ecto.Changeset{}}

  """
  def delete_contact_live(%ContactLive{} = contact_live) do
    Repo.delete(contact_live)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking contact_live changes.

  ## Examples

      iex> change_contact_live(contact_live)
      %Ecto.Changeset{data: %ContactLive{}}

  """
  def change_contact_live(%ContactLive{} = contact_live, attrs \\ %{}) do
    ContactLive.changeset(contact_live, attrs)
  end
end
