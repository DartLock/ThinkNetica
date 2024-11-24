defmodule Part6manyToMany.Repo.Migrations.TodoListItem do
  use Ecto.Migration

  def up do
    create table(:todo_list_items) do
      add :todo_item_id, references(:todo_items, on_delete: :delete_all)
      add :todo_list_id, references(:todo_lists, on_delete: :delete_all)
      timestamps()
    end
  end

  def down do
    drop table(:todo_list_items)
  end
end
