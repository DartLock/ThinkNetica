defmodule Part6manyToMany.Schemas.TodoListItem do
  use Ecto.Schema
  import Ecto.Changeset

  schema "todo_list_items" do
    belongs_to :todo_list, Part6manyToMany.Schemas.TodoList
    belongs_to :todo_item, Part6manyToMany.Schemas.TodoItem
    timestamps()
  end

  @doc false
  def changeset(todo_list_item, attrs \\ %{}) do
    todo_list_item
    |> cast(attrs, [])
  end
end
