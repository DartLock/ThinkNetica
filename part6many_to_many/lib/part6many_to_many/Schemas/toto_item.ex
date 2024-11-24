defmodule Part6manyToMany.Schemas.TodoItem do
  use Ecto.Schema
  import Ecto.Changeset

  schema "todo_items" do
    field :desc, :string
    many_to_many :todo_lists, Part6manyToMany.Schemas.TodoList, join_through: Part6manyToMany.Schemas.TodoListItem, on_delete: :delete_all, on_replace: :delete
    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:desc])
    |> validate_required([:desc])
    |> cast_assoc(:todo_lists, drop_param: :delete)
  end
end
