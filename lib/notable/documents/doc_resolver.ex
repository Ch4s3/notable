defmodule Notable.Documents.DocResolver do
  alias Notable.{Documents.Doc, Repo}

  def all(_args, _info) do
    {:ok, Repo.all(Doc)}
  end
end
