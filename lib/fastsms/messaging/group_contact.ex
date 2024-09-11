defmodule Fastsms.Messaging.GroupContact do
  alias Fastsms.Repo
  use Ecto.Schema
  import Ecto.Changeset

  schema "group_contacts" do

    #    field :group_id, :id
    #    field :contact_id, :id
    belongs_to :group, Messaging.Group
    belongs_to :contact, Messaging.Contact


    timestamps(type: :utc_datetime)
  end

  @required [:group_id, :contact_id]

  @doc false
  def changeset(group_contact, attrs) do
    group_contact
    |> Repo.preload(:group)
    |> Repo.preload(:contact)
    |> cast(attrs, @required)
    |> validate_required(@required)
  end
end
