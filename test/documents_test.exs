defmodule Notable.DocumentsTest do
  use Notable.DataCase

  alias Notable.Documents
  alias Notable.Documents.Doc

  @create_attrs %{body: "some body", length: 42, title: "some title"}
  @update_attrs %{body: "some updated body", length: 43, title: "some updated title"}
  @invalid_attrs %{body: nil, length: nil, title: nil}

  def fixture(:doc, attrs \\ @create_attrs) do
    {:ok, doc} = Documents.create_doc(attrs)
    doc
  end

  test "list_docs/1 returns all docs" do
    doc = fixture(:doc)
    assert Documents.list_docs() == [doc]
  end

  test "get_doc! returns the doc with given id" do
    doc = fixture(:doc)
    assert Documents.get_doc!(doc.id) == doc
  end

  test "create_doc/1 with valid data creates a doc" do
    assert {:ok, %Doc{} = doc} = Documents.create_doc(@create_attrs)
    assert doc.body == "some body"
    assert doc.length == 42
    assert doc.title == "some title"
  end

  test "create_doc/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = Documents.create_doc(@invalid_attrs)
  end

  test "update_doc/2 with valid data updates the doc" do
    doc = fixture(:doc)
    assert {:ok, doc} = Documents.update_doc(doc, @update_attrs)
    assert %Doc{} = doc
    assert doc.body == "some updated body"
    assert doc.length == 43
    assert doc.title == "some updated title"
  end

  test "update_doc/2 with invalid data returns error changeset" do
    doc = fixture(:doc)
    assert {:error, %Ecto.Changeset{}} = Documents.update_doc(doc, @invalid_attrs)
    assert doc == Documents.get_doc!(doc.id)
  end

  test "delete_doc/1 deletes the doc" do
    doc = fixture(:doc)
    assert {:ok, %Doc{}} = Documents.delete_doc(doc)
    assert_raise Ecto.NoResultsError, fn -> Documents.get_doc!(doc.id) end
  end

  test "change_doc/1 returns a doc changeset" do
    doc = fixture(:doc)
    assert %Ecto.Changeset{} = Documents.change_doc(doc)
  end
end
