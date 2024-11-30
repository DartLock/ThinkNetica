defmodule Part6manyToMany.TodoListItem do
  import Ecto.Query, warn: false
  alias Part6manyToMany.Repo

  alias Part6manyToMany.Schemas.TodoListItem
  alias Part6manyToMany.Schemas.TodoList
  alias Part6manyToMany.Schemas.TodoItem

  @doc """
  Returns the list of relations.

  ## Examples
    iex> all()\\
    [%TodoListItem{}, ...]
  """
  def all do
    query =
      from a in TodoListItem,
      join: l in TodoList,
      on: l.id == a.todo_list_id,
      join: i in TodoItem,
      on: i.id == a.todo_item_id,
      preload: [:todo_list, :todo_item]

    Repo.all(query)
  end

  @doc """
  Returns the last record of todo_list_items.

  ## Examples
    iex> first()\\
    %TodoListItem{}
  """
  def first() do
    query = from list_item in TodoListItem, as: :todo_list_items, order_by: [desc: :updated_at]

    Enum.at(Repo.all(query), 0)
  end

  @doc """
  Returns the last record of todo_list_items.

  ## Examples
    iex> last()\\
    %TodoListItem{}
  """
  def last() do
    query = from list_item in TodoListItem, as: :todo_list_items, order_by: [desc: :updated_at]

    Enum.at(Repo.all(query), -1)
  end

  @doc """
  Gets a single relation.

  Raises `Ecto.NoResultsError` if the TodoListItem does not exist.

  ## Examples
    iex> get_item!(123)\\
    %TodoListItem{}

    iex> get_item!(456)\\
    ** (Ecto.NoResultsError)
  """
  def get_item!(id), do: Repo.get!(TodoListItem, id)

  @doc """
  Creates a relation.

  ## Examples
    iex> create(%{field: value})\\
    {:ok, %TodoListItem{}}

    iex> create(%{field: bad_value})\\
    {:error, %Ecto.Changeset{}}
  """
  def create(%{todo_item: item, todo_list: list}) do
    todo_list_item = %Part6manyToMany.Schemas.TodoListItem{
      todo_item: item,
      todo_item_id: item.id,
      todo_list: list,
      todo_list_id: list.id
    }

    Repo.insert!(todo_list_item)
  end

  @doc """
  Updates a relation.

  ## Examples
    iex> update(relation, %{field: new_value})\\
    {:ok, %TodoListItem{}}

    iex> update(relation, %{field: bad_value})\\
    {:error, %Ecto.Changeset{}}
  """
  def update(%TodoListItem{} = relation, attrs) do
    relation
    |> TodoListItem.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a relation.
  ## Examples
    iex> delete(relation)\\
    {:ok, %TodoListItem{}}

    iex> delete(relation)\\
    {:error, %Ecto.Changeset{}}
  """
  def delete(relation), do: Repo.delete(relation)

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking relation changes.
  ## Examples
    iex> change(relation)\\
    %Ecto.Changeset{data: %TodoListItem{}}
  """
  def change(%TodoListItem{} = relation, attrs \\ %{}), do: TodoListItem.changeset(relation, attrs)
end
