defmodule Part6manyToMany.Repo.Migrations.TodoItems do
  use Ecto.Migration

  def up do
    create table(:todo_items)  do
      add :desc, :string
      timestamps()
    end
  end

  def down do
    drop table(:todo_items)
  end
end
