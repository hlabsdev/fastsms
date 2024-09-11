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
end
