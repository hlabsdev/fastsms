defmodule Fastsms.Repo.Migrations.CreateApiConfigurations do
  use Ecto.Migration

  def change do
    create table(:api_configurations) do
      add :api_name, :string
      add :api_key, :string
      add :default, :boolean, default: false, null: false

      timestamps(type: :utc_datetime)
    end
  end
end
