defmodule Part6manyToMany.TodoListTest do
  use ExUnit.Case
  alias Part6manyToMany.TodoList
  alias Part6manyToMany.Debug
  use Part6manyToMany.DataCase

  describe "todo_lists" do
    test "all/0 returns all todo_list" do
      {:ok, todo_list} = TodoList.create(%{title: "TodoList Title"})

      assert TodoList.all() == [todo_list]
    end
  end
end
