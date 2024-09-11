defmodule Fastsms.Messaging.APIConfiguration do
  use Ecto.Schema
  import Ecto.Changeset

  schema "api_configurations" do
    field :default, :boolean, default: false
    field :api_key, :string
    field :api_name, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(api_configuration, attrs) do
    api_configuration
    |> cast(attrs, [:api_name, :api_key, :default])
    |> validate_required([:api_name, :api_key, :default])
  end
end
