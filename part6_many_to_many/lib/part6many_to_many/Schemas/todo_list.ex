defmodule Part6manyToMany.Schemas.TodoList do
  use Ecto.Schema
  import Ecto.Changeset
  alias Part6manyToMany.Debug

  schema "todo_lists" do
    field :title, :string
    many_to_many :todo_items, Part6manyToMany.Schemas.TodoItem, join_through: Part6manyToMany.Schemas.TodoListItem, on_delete: :delete_all, on_replace: :delete
    timestamps()
  end

  @doc false
  def changeset(list, attrs) do
    list
    |> cast(attrs, [:title])
    |> validate_required([:title])
    |> cast_assoc(:todo_items, drop_param: :delete)
  end
end
