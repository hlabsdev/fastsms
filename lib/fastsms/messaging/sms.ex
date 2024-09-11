defmodule Fastsms.Messaging.SMS do
  use Ecto.Schema
  import Ecto.Changeset

  schema "smses" do
    field :message, :string
    field :status, :string
    field :sent_at, :utc_datetime
    field :dynamic_fields, :map
    field :contact_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(sms, attrs) do
    sms
    |> cast(attrs, [:message, :sent_at, :status, :dynamic_fields])
    |> validate_required([:message, :sent_at, :status])
  end
end
