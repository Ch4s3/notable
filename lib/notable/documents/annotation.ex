defmodule Notable.Documents.Annotation do
  use Ecto.Schema

  schema "documents_annotations" do
    field :text, :string
    belongs_to :accounts_users, Notable.Accounts.User, foreign_key: :accounts_users_id
    belongs_to :documents_docs, Notable.Documents.Doc, foreign_key: :documents_docs_id

    timestamps()
  end
end
