defmodule Notable.Accounts.User do
  use Ecto.Schema

  schema "accounts_users" do
    field :email, :string
    field :name, :string
    has_many :documents_docs, Notable.Documents.Doc, foreign_key: :accounts_users_id
    has_many :documents_annotations, Notable.Documents.Annotation, foreign_key: :accounts_users_id
    timestamps()
  end
end
