defmodule Part6manyToMany.Schemas.TodoList do
  use Ecto.Schema
  import Ecto.Changeset

  schema "todo_lists" do
    field :title, :string
    many_to_many :todo_items, Part6manyToMany.Schemas.TodoItem, join_through: Part6manyToMany.TodoListItem
    timestamps()
  end

  @doc false
  def changeset(todo_list, attrs) do
    todo_list
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
