defmodule Notable.Documents.Doc do
  use Ecto.Schema

  schema "documents_docs" do
    field :body, :string
    field :length, :integer
    field :title, :string
    belongs_to :accounts_users, Notable.Accounts.User, foreign_key: :accounts_users_id
    has_many :documents_annotations, Notable.Documents.Annotation, foreign_key: :documents_docs_id

    timestamps()
  end
end
