defmodule Part6manyToMany.Repo.Migrations.TodoLists do
  use Ecto.Migration

  def up do
    create table(:todo_lists)  do
      add :title, :string
      timestamps()
    end
  end

  def down do
    drop table(:todo_lists)
  end
end
