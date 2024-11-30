defmodule Part6manyToMany.TodoList do
  import Ecto.Query, warn: false
  alias Part6manyToMany.Repo
  alias Part6manyToMany.Schemas.TodoList
  alias Part6manyToMany.Debug

  @doc """
  Returns the list of todo_lists.

  ## Examples
    iex> all()\\
    [%TodoList{}, ...]
  """
  def all(), do: Repo.all(TodoList)

  @doc """
  Returns the last record of todo_lists.

  ## Examples
    iex> first()\\
    %TodoList{}
  """
  def first() do
    query = from list in TodoList, as: :todo_lists, order_by: [desc: :updated_at]

    Enum.at(Repo.all(query), 0)
  end

  @doc """
  Returns the last record of todo_lists.

  ## Examples
    iex> last()\\
    %TodoList{}
  """
  def last() do
    query = from list in TodoList, as: :todo_lists, order_by: [desc: :updated_at]

    Enum.at(Repo.all(query), -1)
  end

  @doc """
  Gets a single todo_list.

  Raises `Ecto.NoResultsError` if the TodoList does not exist.

  ## Examples
    iex> get_list!(123)\\
    %TodoList{}

    iex> get_list!(456)\\
    ** (Ecto.NoResultsError)
  """
  def get_list!(id), do: Repo.get!(TodoList, id)

  @doc """
  Creates a todo_list.

  ## Examples
    iex> create(%{field: value})\\
    {:ok, %TodoList{}}

    iex> create(%{field: bad_value})\\
    {:error, %Ecto.Changeset{}}
  """
  def create(list \\ %{}) do
    %TodoList{}
    |> TodoList.changeset(list)
    |> Repo.insert()
  end

  @doc """
  Updates a todo_list.

  ## Examples
    iex> update_todo_list(todo_list, %{field: new_value})\\
    {:ok, %TodoList{}}

    iex> update_todo_list(todo_list, %{field: bad_value})\\
    {:error, %Ecto.Changeset{}}
  """
  def update_todo_list(%TodoList{} = todo_list, attrs) do
    todo_list
    |> TodoList.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a todo_list.
  ## Examples
    iex> delete_todo_list(todo_list)\\
    {:ok, %TodoList{}}

    iex> delete_todo_list(todo_list)\\
    {:error, %Ecto.Changeset{}}
  """
  def delete(todo_list), do: Repo.delete!(todo_list)

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking todo_list changes.
  ## Examples
    iex> change_todo_list(todo_list)\\
    %Ecto.Changeset{data: %TodoList{}}
  """
  def change_todo_list(%TodoList{} = todo_list, attrs \\ %{}), do: TodoList.changeset(todo_list, attrs)
end
