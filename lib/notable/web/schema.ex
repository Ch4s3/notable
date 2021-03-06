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

    field :documents_annotation, type: :documents_annotation do
      arg :id, non_null(:id)
      resolve &Notable.Documents.AnnotationResolver.one/2
    end

    field :accounts_users, list_of(:accounts_user) do
      resolve &Notable.Accounts.UserResolver.all/2
    end
  end

  mutation do
    field :documents_doc, type: :documents_doc do
      arg :title, non_null(:string)
      arg :body, non_null(:string)

      resolve &Notable.Documents.DocResolver.create/2
    end

    field :documents_annotation, type: :documents_annotation do
      arg :text, non_null(:string)
      arg :start_char, non_null(:integer)
      arg :end_char, non_null(:integer)
      arg :documents_docs_id, non_null(:integer)

      resolve &Notable.Documents.AnnotationResolver.create/2
    end
  end
end
