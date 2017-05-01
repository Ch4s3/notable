defmodule Notable.Documents.Doc do
  use Ecto.Schema
  import Ecto.Changeset

  schema "documents_docs" do
    field :body, :string
    field :length, :integer
    field :title, :string
    belongs_to :accounts_users, Notable.Accounts.User, foreign_key: :accounts_users_id
    has_many :documents_annotations, Notable.Documents.Annotation, foreign_key: :documents_docs_id

    timestamps()
  end

  def changeset(doc, params \\ %{}) do
    doc
    |> cast(params, [:body, :title])
    |> validate_required([:body, :title])
    |> body_length
  end

  defp body_length(%{valid?: false} = changeset), do: changeset
  defp body_length(%{valid?: true} = changeset) do
    length =
      changeset
      |> get_field(:body)
      |> String.length

    changeset
    |> put_change(:length, length)
  end
end
