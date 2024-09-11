defmodule Fastsms.Messaging.Contact do
  use Ecto.Schema
  import Ecto.Changeset

  schema "contacts" do
    field :address, :string
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :phone_number, :string

    many_to_many :groups, Messaging.Group, join_through: "group_contacts"
    has_many :smses, Messaging.SMS

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(contact, attrs) do
    contact
    |> cast(attrs, [:first_name, :last_name, :phone_number, :email, :address])
    |> validate_required([:first_name, :last_name, :phone_number, :email, :address])
    |> unique_constraint(:phone_number)
  end
end
