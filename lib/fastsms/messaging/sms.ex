defmodule Fastsms.Messaging.SMS do
  alias Fastsms.Repo
  use Ecto.Schema
  import Ecto.Changeset

  schema "smses" do
    field :message, :string
    field :status, :string
    field :sent_at, :utc_datetime
    field :dynamic_fields, :map
#    field :contact_id, :id

    belongs_to :contact, Messaging.Contact

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(sms, attrs) do
    sms
    |> Repo.preload(:contact)
    |> cast(attrs, [:message, :sent_at, :status, :dynamic_fields])
    |> validate_required([:message, :sent_at, :status])
  end
end
