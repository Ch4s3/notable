defmodule Notable.Documents.Annotation do
  use Ecto.Schema
  import Ecto.Changeset

  schema "documents_annotations" do
    field :text, :string
    field :start_char, :integer
    field :end_char, :integer
    belongs_to :accounts_users, Notable.Accounts.User, foreign_key: :accounts_users_id
    belongs_to :documents_docs, Notable.Documents.Doc, foreign_key: :documents_docs_id

    timestamps()
  end

  def changeset(doc, params \\ %{}) do
    doc
    |> cast(params, [:text, :start_char, :end_char, :documents_docs_id])
    |> validate_required([:text, :start_char, :end_char, :documents_docs_id])
  end
end
