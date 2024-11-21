defmodule Part6manyToMany.Schemas.TodoListItem do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  schema "todo_list_items" do
    belongs_to :todo_list, Part6manyToMany.Schemas.TodoList
    belongs_to :todo_item, Part6manyToMany.Schemas.TodoItem
    timestamps()
  end

  @doc false
  def changeset(todo_list_item, attrs) do
    todo_list_item
    |> cast(attrs)
  end

  def cast(list, item), do: {:ok, list, item}

  def cast(attrs), do: {:ok, attrs}
end
