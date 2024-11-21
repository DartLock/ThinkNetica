defmodule Part6manyToMany.TodoListItemFixtures do
  import Part6manyToMany.TodoListFixtures
  import Part6manyToMany.TodoItemFixtures

  @moduledoc """
  This module defines test helpers for creating
  entities via the `Part6manyToMany.TodoListItem` context.
  """

  @doc """
  Generate a todo_list_item.
  """
  def todo_list_item_fixture(%{todo_item: item, todo_list: list}) do
    Part6manyToMany.TodoListItem.create(%{todo_item: item, todo_list: list})
  end
end
