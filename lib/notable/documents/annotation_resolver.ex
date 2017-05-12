defmodule Notable.Documents.AnnotationResolver do
  alias Notable.{Documents.Annotation, Repo}
  import Ecto.Query

  def all(_args, _info) do
    {:ok, Repo.all(from a in Annotation, order_by: a.start_char)}
  end

  def one(args, _info) do
    id = String.to_integer(args.id)
    {:ok, Repo.one(from a in Annotation, where: a.id == ^id)}
  end

  def create(args, _info) do
    changeset =
      %Annotation{}
      |> Annotation.changeset(args)
    case changeset.valid? do
      true ->
        Repo.insert(changeset)
      false ->
        error_map =
          changeset.errors
          |> Enum.into(%{})
        # error_key =
        #   error_map
        #   |> Map.keys
        #   |> List.first
        error_value =
          error_map
          |> Map.values
          |> List.first
          |> Tuple.to_list
          |> List.first
        # require IEx
        # IEx.pry
        {:error, error_value}
    end
  end
end
