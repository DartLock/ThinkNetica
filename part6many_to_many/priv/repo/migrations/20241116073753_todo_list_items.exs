defmodule Part6manyToMany.Repo.Migrations.TodoListItem do
  use Ecto.Migration

  def up do
    create table(:todo_list_items, primary_key: false) do
      add :todo_item_id, references(:todo_items)
      add :todo_list_id, references(:todo_lists)
      timestamps()
    end
  end

  def down do
    drop table(:todo_list_items)
  end
end
