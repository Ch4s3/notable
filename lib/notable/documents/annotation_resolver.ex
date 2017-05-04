defmodule Notable.Documents.AnnotationResolver do
  alias Notable.{Documents.Annotation, Repo}

  def all(_args, _info) do
    {:ok, Repo.all(Annotation)}
  end

  def create(args, _info) do
    %Annotation{}
    |> Annotation.changeset(args)
    |> Repo.insert
  end
end
