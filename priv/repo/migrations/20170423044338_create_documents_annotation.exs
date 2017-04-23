defmodule Notable.Repo.Migrations.CreateNotable.Documents.Annotation do
  use Ecto.Migration

  def change do
    create table(:documents_annotations) do
      add :text, :text
      add :accounts_users_id, references(:accounts_users, on_delete: :nothing)
      add :documents_docs_id, references(:documents_docs, on_delete: :nothing)

      timestamps()
    end

    create index(:documents_annotations, [:accounts_users_id])
    create index(:documents_annotations, [:documents_docs_id])
  end
end
