defmodule Part6manyToMany.TodoItem do
  import Ecto.Query, warn: false
  alias Part6manyToMany.Repo
  alias Part6manyToMany.Schemas.TodoItem


  @doc """
  Returns the item of todo_items.

  ## Examples
    iex> all()\\
    [%TodoItem{}, ...]
  """
  def all do
    Repo.all(TodoItem)
  end

  @doc """
  Gets a single todo_item.

  Raises `Ecto.NoResultsError` if the TodoItem does not exist.

  ## Examples
    iex> get_item!(123)\\
    %TodoItem{}

    iex> get_item!(456)\\
    ** (Ecto.NoResultsError)
  """
  def get_item!(id), do: Repo.get!(TodoItem, id)

  @doc """
  Creates a todo_item.

  ## Examples
    iex> create_todo_item(%{field: value})\\
    {:ok, %TodoItem{}}

    iex> create_todo_item(%{field: bad_value})\\
    {:error, %Ecto.Changeset{}}
  """
  def create_todo_item(attrs \\ %{}) do
    %TodoItem{}
    |> TodoItem.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a todo_item.

  ## Examples
    iex> update_todo_item(todo_item, %{field: new_value})\\
    {:ok, %TodoItem{}}

    iex> update_todo_item(todo_item, %{field: bad_value})\\
    {:error, %Ecto.Changeset{}}
  """
  def update_todo_item(%TodoItem{} = todo_item, attrs) do
    todo_item
    |> TodoItem.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a todo_item.
  ## Examples
    iex> delete_todo_item(todo_item)\\
    {:ok, %TodoItem{}}

    iex> delete_todo_item(todo_item)\\
    {:error, %Ecto.Changeset{}}
  """
  def delete_todo_item(%TodoItem{} = todo_item) do
    Repo.delete(todo_item)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking todo_item changes.
  ## Examples
    iex> change_todo_item(todo_item)\\
    %Ecto.Changeset{data: %TodoItem{}}
  """
  def change_todo_item(%TodoItem{} = todo_item, attrs \\ %{}) do
    TodoItem.changeset(todo_item, attrs)
  end
end
