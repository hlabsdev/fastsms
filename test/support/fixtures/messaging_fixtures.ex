defmodule Fastsms.MessagingFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Fastsms.Messaging` context.
  """

  @doc """
  Generate a unique contact phone_number.
  """
  def unique_contact_phone_number, do: "some phone_number#{System.unique_integer([:positive])}"

  @doc """
  Generate a contact.
  """
  def contact_fixture(attrs \\ %{}) do
    {:ok, contact} =
      attrs
      |> Enum.into(%{
        address: "some address",
        email: "some email",
        first_name: "some first_name",
        last_name: "some last_name",
        phone_number: unique_contact_phone_number()
      })
      |> Fastsms.Messaging.create_contact()

    contact
  end

  @doc """
  Generate a unique group name.
  """
  def unique_group_name, do: "some name#{System.unique_integer([:positive])}"

  @doc """
  Generate a group.
  """
  def group_fixture(attrs \\ %{}) do
    {:ok, group} =
      attrs
      |> Enum.into(%{
        name: unique_group_name()
      })
      |> Fastsms.Messaging.create_group()

    group
  end

  @doc """
  Generate a sms.
  """
  def sms_fixture(attrs \\ %{}) do
    {:ok, sms} =
      attrs
      |> Enum.into(%{
        dynamic_fields: %{},
        message: "some message",
        sent_at: ~U[2024-09-10 05:10:00Z],
        status: "some status"
      })
      |> Fastsms.Messaging.create_sms()

    sms
  end

  @doc """
  Generate a scheduled_sms.
  """
  def scheduled_sms_fixture(attrs \\ %{}) do
    {:ok, scheduled_sms} =
      attrs
      |> Enum.into(%{
        message: "some message",
        recurrence: "some recurrence",
        scheduled_at: ~U[2024-09-10 05:12:00Z]
      })
      |> Fastsms.Messaging.create_scheduled_sms()

    scheduled_sms
  end
end
