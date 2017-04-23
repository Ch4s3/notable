defmodule Notable.Web.DocController do
  use Notable.Web, :controller

  alias Notable.Documents

  def index(conn, _params) do
    docs = Documents.list_docs()
    IO.puts(get_format(conn))
    render(conn, :index, docs: docs)
  end

  def new(conn, _params) do
    changeset = Documents.change_doc(%Notable.Documents.Doc{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"doc" => doc_params}) do
    case Documents.create_doc(doc_params) do
      {:ok, doc} ->
        conn
        |> put_flash(:info, "Doc created successfully.")
        |> redirect(to: doc_path(conn, :show, doc))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    doc = Documents.get_doc!(id)
    render(conn, "show.html", doc: doc)
  end

  def edit(conn, %{"id" => id}) do
    doc = Documents.get_doc!(id)
    changeset = Documents.change_doc(doc)
    render(conn, "edit.html", doc: doc, changeset: changeset)
  end

  def update(conn, %{"id" => id, "doc" => doc_params}) do
    doc = Documents.get_doc!(id)

    case Documents.update_doc(doc, doc_params) do
      {:ok, doc} ->
        conn
        |> put_flash(:info, "Doc updated successfully.")
        |> redirect(to: doc_path(conn, :show, doc))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", doc: doc, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    doc = Documents.get_doc!(id)
    {:ok, _doc} = Documents.delete_doc(doc)

    conn
    |> put_flash(:info, "Doc deleted successfully.")
    |> redirect(to: doc_path(conn, :index))
  end
end
