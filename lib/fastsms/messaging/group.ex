defmodule Fastsms.Messaging.Group do

  alias Fastsms.Repo

  use Ecto.Schema
  import Ecto.Changeset

  schema "groups" do
    field :name, :string

    many_to_many :contacts, Fastsms.Messaging.Contact, join_through: "group_contacts", on_replace: :delete
    has_many :scheduled_smses, Fastsms.Messaging.ScheduledSMS

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(group, attrs) do
    group
    |> Repo.preload(:contacts)  # Assurez-vous que l'association contacts est chargée
    |> Repo.preload(:scheduled_smses)
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
    |> maybe_put_contacts(attrs)
    |> maybe_put_scheduled_smses(attrs)
  end

  defp maybe_put_contacts(changeset, %{"contact_ids" => contact_ids}) when is_list(contact_ids) do
    contacts = Fastsms.Messaging.list_contacts(contact_ids)
    put_assoc(changeset, :contacts, contacts)
  end

  defp maybe_put_contacts(changeset, _), do: changeset

  defp maybe_put_scheduled_smses(changeset, %{"scheduled_smses" => scheduled_smses_params}) when is_list(scheduled_smses_params) do
    cast_assoc(changeset, :scheduled_smses, with: &Fastsms.Messaging.ScheduledSMS.changeset/2)
  end
  defp maybe_put_scheduled_smses(changeset, _), do: changeset
end
