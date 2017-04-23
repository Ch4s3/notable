defmodule Notable.Repo.Migrations.CreateNotable.Documents.Doc do
  use Ecto.Migration

  def change do
    create table(:documents_docs) do
      add :title, :string
      add :body, :text
      add :length, :integer
      add :accounts_users_id, references(:accounts_users, on_delete: :nothing)

      timestamps()
    end

    create index(:documents_docs, [:accounts_users_id])
  end
end
