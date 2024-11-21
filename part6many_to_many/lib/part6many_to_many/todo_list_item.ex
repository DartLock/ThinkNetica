defmodule Part6manyToMany.TodoListItems do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  schema "todo_list_items" do
    belongs_to :todo_list, Part6manyToMany.TodoList
    belongs_to :todo_item, Part6manyToMany.TodoItem
    timestamps()
  end

  import Ecto.Query, warn: false
  alias Part6manyToMany.Repo
  alias Part6manyToMany.TodoListItem
  alias Part6manyToMany.TodoList
  alias Part6manyToMany.TodoItem

  @doc false
  def changeset(attrs), do: cast(attrs)

  def cast(list, item), do: {:ok, list, item}

  def cast(attrs), do: {:ok, attrs}

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
    Repo.insert(%TodoListItem{todo_item: item, todo_list: list})
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
  def delete(%TodoListItem{} = relation) do
    Repo.delete(relation)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking relation changes.
  ## Examples
    iex> change(relation)\\
    %Ecto.Changeset{data: %TodoListItem{}}
  """
  def change(%TodoListItem{} = relation, attrs \\ %{}) do
    TodoListItem.changeset(relation, attrs)
  end
end
