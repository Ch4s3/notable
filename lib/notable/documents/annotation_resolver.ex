defmodule Notable.Documents.AnnotationResolver do
  alias Notable.{Documents.Annotation, Repo}

  def all(_args, _info) do
    {:ok, Repo.all(Annotation)}
  end
end
