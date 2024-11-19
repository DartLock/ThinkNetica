defmodule Part6manyToMany.TodoItemFixtures do
  alias Part6manyToMany.Debug

  @moduledoc """
  This module defines test helpers for creating
  entities via the `Part6manyToMany.TodoItem` context.
  """

  @doc """
  Generate a todo_item.
  """
  def todo_item_fixture(desc = %{desc: description} \\ %{desc: "Default description"}) do
    {:ok, todo_item} = Part6manyToMany.TodoItem.create_todo_item(desc)

    todo_item
  end
end
