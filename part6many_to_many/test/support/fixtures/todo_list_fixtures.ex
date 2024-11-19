defmodule Part6manyToMany.TodoListFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Part6manyToMany.TodoList` context.
  """

  @doc """
  Generate a todo_list.
  """
  def todo_list_fixture(title = %{title: entry_title} \\ %{title: "Default Title Fixture"}) do
    {:ok, todo_list} = Part6manyToMany.TodoList.create_todo_list(title)

    todo_list
  end
end
