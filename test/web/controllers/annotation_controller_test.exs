defmodule Notable.Web.AnnotationControllerTest do
  use Notable.Web.ConnCase

  alias Notable.Documents
  alias Notable.Documents.Annotation

  @create_attrs %{text: "some text"}
  @update_attrs %{text: "some updated text"}
  @invalid_attrs %{text: nil}

  def fixture(:annotation) do
    {:ok, annotation} = Documents.create_annotation(@create_attrs)
    annotation
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, annotation_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates annotation and renders annotation when data is valid", %{conn: conn} do
    conn = post conn, annotation_path(conn, :create), annotation: @create_attrs
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, annotation_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "text" => "some text"}
  end

  test "does not create annotation and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, annotation_path(conn, :create), annotation: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen annotation and renders annotation when data is valid", %{conn: conn} do
    %Annotation{id: id} = annotation = fixture(:annotation)
    conn = put conn, annotation_path(conn, :update, annotation), annotation: @update_attrs
    assert %{"id" => ^id} = json_response(conn, 200)["data"]

    conn = get conn, annotation_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "text" => "some updated text"}
  end

  test "does not update chosen annotation and renders errors when data is invalid", %{conn: conn} do
    annotation = fixture(:annotation)
    conn = put conn, annotation_path(conn, :update, annotation), annotation: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen annotation", %{conn: conn} do
    annotation = fixture(:annotation)
    conn = delete conn, annotation_path(conn, :delete, annotation)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, annotation_path(conn, :show, annotation)
    end
  end
end
