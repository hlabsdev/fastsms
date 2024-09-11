defmodule Fastsms.Repo.Migrations.CreateGroupContacts do
  use Ecto.Migration

  def change do
    create table(:group_contacts) do
      add :group_id, references(:groups, on_delete: :nothing)
      add :contact_id, references(:contacts, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:group_contacts, [:group_id])
    create index(:group_contacts, [:contact_id])
  end
end
