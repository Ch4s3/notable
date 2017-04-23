defmodule Notable.Web.AnnotationController do
  use Notable.Web, :controller

  alias Notable.Documents
  alias Notable.Documents.Annotation

  action_fallback Notable.Web.FallbackController

  def index(conn, _params) do
    annotations = Documents.list_annotations()
    render(conn, "index.json", annotations: annotations)
  end

  def create(conn, %{"annotation" => annotation_params}) do
    with {:ok, %Annotation{} = annotation} <- Documents.create_annotation(annotation_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", annotation_path(conn, :show, annotation))
      |> render("show.json", annotation: annotation)
    end
  end

  def show(conn, %{"id" => id}) do
    annotation = Documents.get_annotation!(id)
    render(conn, "show.json", annotation: annotation)
  end

  def update(conn, %{"id" => id, "annotation" => annotation_params}) do
    annotation = Documents.get_annotation!(id)

    with {:ok, %Annotation{} = annotation} <- Documents.update_annotation(annotation, annotation_params) do
      render(conn, "show.json", annotation: annotation)
    end
  end

  def delete(conn, %{"id" => id}) do
    annotation = Documents.get_annotation!(id)
    with {:ok, %Annotation{}} <- Documents.delete_annotation(annotation) do
      send_resp(conn, :no_content, "")
    end
  end
end
