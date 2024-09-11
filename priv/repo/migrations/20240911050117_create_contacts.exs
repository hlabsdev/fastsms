defmodule Fastsms.Repo.Migrations.CreateContacts do
  use Ecto.Migration

  def change do
    create table(:contacts) do
      add :first_name, :string
      add :last_name, :string
      add :phone_number, :string
      add :email, :string
      add :address, :string

      timestamps(type: :utc_datetime)
    end

    create unique_index(:contacts, [:phone_number])
  end
end
