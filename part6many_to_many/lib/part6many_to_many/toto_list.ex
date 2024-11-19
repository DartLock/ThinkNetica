defmodule Part6manyToMany.TodoList do
  use Ecto.Schema
  import Ecto.Changeset

  schema "todo_lists" do
    field :title, :string
    many_to_many :todo_items, Part6manyToMany.TodoItem, join_through: Part6manyToMany.TodoListItem
    timestamps()
  end

  import Ecto.Query, warn: false
  alias Part6manyToMany.Repo
  alias Part6manyToMany.TodoList

  @doc false
  def changeset(todo_list, attrs) do
    todo_list
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end

  @doc """
  Returns the list of todo_lists.

  ## Examples
    iex> all()\\
    [%TodoList{}, ...]
  """
  def all, do: Repo.all(TodoList)

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
    iex> create_todo_list(%{field: value})\\
    {:ok, %TodoList{}}

    iex> create_todo_list(%{field: bad_value})\\
    {:error, %Ecto.Changeset{}}
  """
  def create_todo_list(attrs \\ %{}) do
    %TodoList{}
    |> TodoList.changeset(attrs)
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
  def delete_todo_list(%TodoList{} = todo_list) do
    Repo.delete(todo_list)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking todo_list changes.
  ## Examples
    iex> change_todo_list(todo_list)\\
    %Ecto.Changeset{data: %TodoList{}}
  """
  def change_todo_list(%TodoList{} = todo_list, attrs \\ %{}) do
    TodoList.changeset(todo_list, attrs)
  end
end
