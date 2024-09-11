defmodule Fastsms.Messaging.Contact do
  use Ecto.Schema
  import Ecto.Changeset

  schema "contacts" do
    field :address, :string
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :phone_number, :string

    many_to_many :groups, Fastsms.Messaging.Group, join_through: "group_contacts", on_replace: :delete
    has_many :smses, Fastsms.Messaging.SMS

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(contact, attrs) do
    contact
    |> cast(attrs, [:first_name, :last_name, :phone_number, :email, :address])
    |> validate_required([:first_name, :last_name, :phone_number, :email, :address])
    |> validate_format(:phone_number, ~r/^\+?[\d\s\-\(\)]{7,20}$/)
#    |> validate_phone_number(:phone_number)
    |> unique_constraint(:phone_number)
#    |> maybe_put_groups(attrs)
#    |> maybe_put_smses(attrs)
  end

  defp maybe_put_groups(changeset, %{"group_ids" => group_ids}) when is_list(group_ids) do
    groups = Fastsms.Messaging.list_groups(group_ids)
    put_assoc(changeset, :groups, groups)
  end

#  defp maybe_put_groups(changeset, %{"group_ids" => group_ids}) when is_list(group_ids) do
#    Repo.all(Fastsms.Messaging.Group, id: group_ids)
#    |> put_assoc(changeset, :groups)
#  end

  defp maybe_put_groups(changeset, _), do: changeset

  defp maybe_put_smses(changeset, %{"smses" => smses_params}) when is_list(smses_params) do
    cast_assoc(changeset, :smses, with: &Fastsms.Messaging.SMS.changeset/2)
  end
  defp maybe_put_smses(changeset, _), do: changeset
end
