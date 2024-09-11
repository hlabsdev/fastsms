defmodule Fastsms.Messaging.ScheduledSMS do
  use Ecto.Schema
  import Ecto.Changeset

  schema "scheduled_smses" do
    field :message, :string
    field :scheduled_at, :utc_datetime
    field :recurrence, :string
#    field :contact_id, :id
#    field :group_id, :id

    belongs_to :contact, Messaging.Contact
    belongs_to :group, Messaging.Group

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(scheduled_sms, attrs) do
    scheduled_sms
    |> cast(attrs, [:message, :scheduled_at, :recurrence])
    |> validate_required([:message, :scheduled_at, :recurrence])
  end
end
