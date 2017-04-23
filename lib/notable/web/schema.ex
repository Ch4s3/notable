defmodule Notable.Schema do
  use Absinthe.Schema
  import_types Notable.Schema.Types

  query do
    field :documents_docs, list_of(:documents_doc) do
      resolve &Notable.Documents.DocResolver.all/2
    end

    field :documents_annotations, list_of(:documents_annotation) do
      resolve &Notable.Documents.AnnotationResolver.all/2
    end

    field :accounts_users, list_of(:accounts_user) do
      resolve &Notable.Accounts.UserResolver.all/2
    end
  end
end
