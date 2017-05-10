defmodule Notable.Documents.AnnotationResolver do
  alias Notable.{Documents.Annotation, Repo}

  def all(_args, _info) do
    {:ok, Repo.all(Annotation)}
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
