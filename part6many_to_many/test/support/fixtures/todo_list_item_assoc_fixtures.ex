defmodule Part6manyToMany.TodoListItemAssocFixtures do
  import Part6manyToMany.TodoListFixtures
  import Part6manyToMany.TodoItemFixtures

  @moduledoc """
  This module defines test helpers for creating
  entities via the `Part6manyToMany.TodoListItemAssoc` context.
  """

  @doc """
  Generate a todo_list_item_assoc.
  """
  def todo_list_item_assoc_fixture(%{todo_item: item, todo_list: list}) do
    Part6manyToMany.TodoListItemAssoc.create_assoc(%{todo_item: item, todo_list: list})
  end
end
