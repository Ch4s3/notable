defmodule Notable.Web.DocView do
  use Notable.Web, :view
  alias Notable.Web.DocView

  def render("index.json", %{docs: docs}) do
    %{data: render_many(docs, DocView, "doc.json")}
  end

  def render("show.json", %{doc: doc}) do
    %{data: render_one(doc, DocView, "doc.json")}
  end

  def render("doc.json", %{doc: doc}) do
    %{id: doc.id,
      title: doc.title,
      body: doc.body,
      length: doc.length}
  end
end
