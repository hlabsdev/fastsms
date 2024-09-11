defmodule Fastsms.Repo.Migrations.CreateSmses do
  use Ecto.Migration

  def change do
    create table(:smses) do
      add :message, :text
      add :sent_at, :utc_datetime
      add :status, :string
      add :dynamic_fields, :map
      add :contact_id, references(:contacts, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:smses, [:contact_id])
  end
end
