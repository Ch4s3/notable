defmodule Notable.Documents.Annotation do
  use Ecto.Schema
  import Ecto.{Changeset, Query}
  alias Notable.Repo
  alias Notable.Documents.Annotation

  schema "documents_annotations" do
    field :text, :string
    field :start_char, :integer
    field :end_char, :integer
    belongs_to :accounts_users, Notable.Accounts.User, foreign_key: :accounts_users_id
    belongs_to :documents_docs, Notable.Documents.Doc, foreign_key: :documents_docs_id

    timestamps()
  end

  def changeset(annotation, params \\ %{}) do
    annotation
    |> cast(params, [:text, :start_char, :end_char, :documents_docs_id])
    |> validate_required([:text, :start_char, :end_char, :documents_docs_id])
    |> validate_overlap
  end

  def validate_overlap(changeset) do
    range =
      get_field(changeset, :start_char)..get_field(changeset, :end_char)
      |> Enum.to_list
    valid? =
      get_field(changeset, :documents_docs_id)
      |> get_siblings
      |> get_start_to_end_range
      |> check_disjoint_sets(range)

    case valid? do
      true ->
        changeset
      false ->
        add_error(changeset, :start_char, "May not overlap another Annotation")
    end

  end

  def get_siblings(doc_id) do
    query = from a in Annotation, where: a.documents_docs_id == type(^doc_id, :integer)
    Repo.all(query)
  end

  def check_disjoint_sets(sibling_range_lists, changeset_range_list) do
    change_map_set = MapSet.new(changeset_range_list)
    Enum.map(sibling_range_lists, fn (rl) ->
      MapSet.disjoint?(MapSet.new(rl), change_map_set)
    end)
    |> Enum.reduce(true, fn(bool, acc) -> bool && acc end)
  end

  def get_start_to_end_range(annotations) do
    Enum.map(annotations, fn (a) -> Enum.to_list(a.start_char..a.end_char) end)
  end
end
