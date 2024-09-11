defmodule Fastsms.Messaging.GroupContact do
  use Ecto.Schema
  import Ecto.Changeset

  schema "group_contacts" do

#    field :group_id, :id
#    field :contact_id, :id
    belongs_to :group, Messaging.Group
    belongs_to :contact, Messaging.Contact


    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(group_contact, attrs) do
    group_contact
    |> cast(attrs, [])
    |> validate_required([])
  end
end
