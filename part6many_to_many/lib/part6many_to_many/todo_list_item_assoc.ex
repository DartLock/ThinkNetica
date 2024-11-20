defmodule Part6manyToMany.TodoListItems do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  schema "todo_list_item_assocs" do
    belongs_to :todo_list, Part6manyToMany.TodoList
    belongs_to :todo_item, Part6manyToMany.TodoItem
    timestamps()
  end

  import Ecto.Query, warn: false
  alias Part6manyToMany.Repo
  alias Part6manyToMany.TodoListItemAssoc
  alias Part6manyToMany.TodoList
  alias Part6manyToMany.TodoItem

  @doc false
  def changeset(attrs), do: cast(attrs)

  def cast(list, item), do: {:ok, list, item}

  def cast(attrs), do: {:ok, attrs}

  @doc """
  Returns the list of assocs.

  ## Examples
    iex> all()\\
    [%TodoListItemAssoc{}, ...]
  """
  def all do
    query =
      from a in TodoListItemAssoc,
      join: l in TodoList,
      on: l.id == a.todo_list_id,
      join: i in TodoItem,
      on: i.id == a.todo_item_id,
      preload: [:todo_list, :todo_item]

    Repo.all(query)
  end

  @doc """
  Gets a single assoc.

  Raises `Ecto.NoResultsError` if the TodoListItemAssoc does not exist.

  ## Examples
    iex> get_item!(123)\\
    %TodoListItemAssoc{}

    iex> get_item!(456)\\
    ** (Ecto.NoResultsError)
  """
  def get_item!(id), do: Repo.get!(TodoListItemAssoc, id)

  @doc """
  Creates a assoc.

  ## Examples
    iex> create_assoc(%{field: value})\\
    {:ok, %TodoListItemAssoc{}}

    iex> create_assoc(%{field: bad_value})\\
    {:error, %Ecto.Changeset{}}
  """
  def create_assoc(%{todo_item: item, todo_list: list}) do
    Repo.insert(%TodoListItemAssoc{todo_item: item, todo_list: list})
  end

  @doc """
  Updates a assoc.

  ## Examples
    iex> update_assoc(assoc, %{field: new_value})\\
    {:ok, %TodoListItemAssoc{}}

    iex> update_assoc(assoc, %{field: bad_value})\\
    {:error, %Ecto.Changeset{}}
  """
  def update_assoc(%TodoListItemAssoc{} = assoc, attrs) do
    assoc
    |> TodoListItemAssoc.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a assoc.
  ## Examples
    iex> delete_assoc(assoc)\\
    {:ok, %TodoListItemAssoc{}}

    iex> delete_assoc(assoc)\\
    {:error, %Ecto.Changeset{}}
  """
  def delete_assoc(%TodoListItemAssoc{} = assoc) do
    Repo.delete(assoc)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking assoc changes.
  ## Examples
    iex> change_assoc(assoc)\\
    %Ecto.Changeset{data: %TodoListItemAssoc{}}
  """
  def change_assoc(%TodoListItemAssoc{} = assoc, attrs \\ %{}) do
    TodoListItemAssoc.changeset(assoc, attrs)
  end
end
