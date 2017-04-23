defmodule Notable.Documents do
  @moduledoc """
  The boundary for the Documents system.
  """

  import Ecto.{Query, Changeset}, warn: false
  alias Notable.Repo

  alias Notable.Documents.Doc

  @doc """
  Returns the list of docs.

  ## Examples

      iex> list_docs()
      [%Doc{}, ...]

  """
  def list_docs do
    Repo.all(Doc)
  end

  @doc """
  Gets a single doc.

  Raises `Ecto.NoResultsError` if the Doc does not exist.

  ## Examples

      iex> get_doc!(123)
      %Doc{}

      iex> get_doc!(456)
      ** (Ecto.NoResultsError)

  """
  def get_doc!(id), do: Repo.get!(Doc, id)

  @doc """
  Creates a doc.

  ## Examples

      iex> create_doc(%{field: value})
      {:ok, %Doc{}}

      iex> create_doc(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_doc(attrs \\ %{}) do
    %Doc{}
    |> doc_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a doc.

  ## Examples

      iex> update_doc(doc, %{field: new_value})
      {:ok, %Doc{}}

      iex> update_doc(doc, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_doc(%Doc{} = doc, attrs) do
    doc
    |> doc_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Doc.

  ## Examples

      iex> delete_doc(doc)
      {:ok, %Doc{}}

      iex> delete_doc(doc)
      {:error, %Ecto.Changeset{}}

  """
  def delete_doc(%Doc{} = doc) do
    Repo.delete(doc)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking doc changes.

  ## Examples

      iex> change_doc(doc)
      %Ecto.Changeset{source: %Doc{}}

  """
  def change_doc(%Doc{} = doc) do
    doc_changeset(doc, %{})
  end

  defp doc_changeset(%Doc{} = doc, attrs) do
    doc
    |> cast(attrs, [:title, :body, :length])
    |> validate_required([:title, :body, :length])
  end

  alias Notable.Documents.Annotation

  @doc """
  Returns the list of annotations.

  ## Examples

      iex> list_annotations()
      [%Annotation{}, ...]

  """
  def list_annotations do
    Repo.all(Annotation)
  end

  @doc """
  Gets a single annotation.

  Raises `Ecto.NoResultsError` if the Annotation does not exist.

  ## Examples

      iex> get_annotation!(123)
      %Annotation{}

      iex> get_annotation!(456)
      ** (Ecto.NoResultsError)

  """
  def get_annotation!(id), do: Repo.get!(Annotation, id)

  @doc """
  Creates a annotation.

  ## Examples

      iex> create_annotation(%{field: value})
      {:ok, %Annotation{}}

      iex> create_annotation(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_annotation(attrs \\ %{}) do
    %Annotation{}
    |> annotation_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a annotation.

  ## Examples

      iex> update_annotation(annotation, %{field: new_value})
      {:ok, %Annotation{}}

      iex> update_annotation(annotation, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_annotation(%Annotation{} = annotation, attrs) do
    annotation
    |> annotation_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Annotation.

  ## Examples

      iex> delete_annotation(annotation)
      {:ok, %Annotation{}}

      iex> delete_annotation(annotation)
      {:error, %Ecto.Changeset{}}

  """
  def delete_annotation(%Annotation{} = annotation) do
    Repo.delete(annotation)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking annotation changes.

  ## Examples

      iex> change_annotation(annotation)
      %Ecto.Changeset{source: %Annotation{}}

  """
  def change_annotation(%Annotation{} = annotation) do
    annotation_changeset(annotation, %{})
  end

  defp annotation_changeset(%Annotation{} = annotation, attrs) do
    annotation
    |> cast(attrs, [:text])
    |> validate_required([:text])
  end
end
