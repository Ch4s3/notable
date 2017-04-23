defmodule Notable.Web.AnnotationView do
  use Notable.Web, :view
  alias Notable.Web.AnnotationView

  def render("index.json", %{annotations: annotations}) do
    %{data: render_many(annotations, AnnotationView, "annotation.json")}
  end

  def render("show.json", %{annotation: annotation}) do
    %{data: render_one(annotation, AnnotationView, "annotation.json")}
  end

  def render("annotation.json", %{annotation: annotation}) do
    %{id: annotation.id,
      text: annotation.text}
  end
end
