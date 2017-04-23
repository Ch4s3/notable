defmodule Notable.Web.DocControllerTest do
  use Notable.Web.ConnCase

  alias Notable.Documents

  @create_attrs %{body: "some body", length: 42, title: "some title"}
  @update_attrs %{body: "some updated body", length: 43, title: "some updated title"}
  @invalid_attrs %{body: nil, length: nil, title: nil}

  def fixture(:doc) do
    {:ok, doc} = Documents.create_doc(@create_attrs)
    doc
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, doc_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing Docs"
  end

  test "renders form for new docs", %{conn: conn} do
    conn = get conn, doc_path(conn, :new)
    assert html_response(conn, 200) =~ "New Doc"
  end

  test "creates doc and redirects to show when data is valid", %{conn: conn} do
    conn = post conn, doc_path(conn, :create), doc: @create_attrs

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == doc_path(conn, :show, id)

    conn = get conn, doc_path(conn, :show, id)
    assert html_response(conn, 200) =~ "Show Doc"
  end

  test "does not create doc and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, doc_path(conn, :create), doc: @invalid_attrs
    assert html_response(conn, 200) =~ "New Doc"
  end

  test "renders form for editing chosen doc", %{conn: conn} do
    doc = fixture(:doc)
    conn = get conn, doc_path(conn, :edit, doc)
    assert html_response(conn, 200) =~ "Edit Doc"
  end

  test "updates chosen doc and redirects when data is valid", %{conn: conn} do
    doc = fixture(:doc)
    conn = put conn, doc_path(conn, :update, doc), doc: @update_attrs
    assert redirected_to(conn) == doc_path(conn, :show, doc)

    conn = get conn, doc_path(conn, :show, doc)
    assert html_response(conn, 200) =~ "some updated body"
  end

  test "does not update chosen doc and renders errors when data is invalid", %{conn: conn} do
    doc = fixture(:doc)
    conn = put conn, doc_path(conn, :update, doc), doc: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit Doc"
  end

  test "deletes chosen doc", %{conn: conn} do
    doc = fixture(:doc)
    conn = delete conn, doc_path(conn, :delete, doc)
    assert redirected_to(conn) == doc_path(conn, :index)
    assert_error_sent 404, fn ->
      get conn, doc_path(conn, :show, doc)
    end
  end
end
