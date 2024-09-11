defmodule Fastsms.Repo.Migrations.CreateScheduledSmses do
  use Ecto.Migration

  def change do
    create table(:scheduled_smses) do
      add :message, :text
      add :scheduled_at, :utc_datetime
      add :recurrence, :string
      add :contact_id, references(:contacts, on_delete: :nothing)
      add :group_id, references(:groups, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:scheduled_smses, [:contact_id])
    create index(:scheduled_smses, [:group_id])
  end
end
