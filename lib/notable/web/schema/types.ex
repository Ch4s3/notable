defmodule Notable.Schema.Types do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Notable.Repo

  object :accounts_user do
    field :id, :id
    field :name, :string
    field :email, :string

    field :docs, list_of(:documents_doc), resolve: assoc(:documents_docs)
    field :annotations, list_of(:documents_annotation), resolve: assoc(:documents_annotations)
  end

  object :documents_doc do
    field :id, :id
    field :title, :string
    field :length, :integer
    field :body, :string

    field :user, :accounts_user, resolve: assoc(:accounts_users)
    field :annotations, list_of(:documents_annotation), resolve: assoc(:documents_annotations)
  end

  @desc "An annotation"
  object :documents_annotation do
    field :id, :id
    field :text, :string

    field :user, :accounts_user, resolve: assoc(:accounts_users)
    field :doc, :documents_doc, resolve: assoc(:documents_docs)
  end
end
