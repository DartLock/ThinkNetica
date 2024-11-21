defmodule Part6manyToMany.Schemas.TodoItem do
  use Ecto.Schema
  import Ecto.Changeset

  schema "todo_items" do
    field :desc, :string
    many_to_many :todo_lists, Part6manyToMany.Schemas.TodoList, join_through: Part6manyToMany.Schemas.TodoListItem
    timestamps()
  end

  @doc false
  def changeset(todo_item, attrs) do
    todo_item
    |> cast(attrs, [:desc])
    |> validate_required([:desc])
  end
end
