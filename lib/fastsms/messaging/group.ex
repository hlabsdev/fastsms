defmodule Fastsms.Messaging.Group do
  use Ecto.Schema
  import Ecto.Changeset

  schema "groups" do
    field :name, :string

    many_to_many :contacts, Fastsms.Messaging.Contact, join_through: "group_contacts"
    has_many :scheduled_smses, Fastsms.Messaging.ScheduledSMS

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(group, attrs) do
    group
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
