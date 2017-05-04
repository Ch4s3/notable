defmodule Notable.Repo.Migrations.AddStartAndEndCharsToAnnotations do
  use Ecto.Migration

  def change do
    alter table(:documents_annotations) do
      add :start_char, :integer
      add :end_char, :integer
    end
  end
end
