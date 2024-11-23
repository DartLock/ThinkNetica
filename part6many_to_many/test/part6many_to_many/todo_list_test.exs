defmodule Part6manyToMany.TodoListTest do
  use ExUnit.Case
  alias Part6manyToMany.TodoList

  use Part6manyToMany.DataCase

  import Part6manyToMany.TodoListFixtures

  describe "todo_lists" do
    test "all/0 returns all todo_list" do
      todo_list = todo_list_fixture()
      assert TodoList.all() == [todo_list]
    end
  end
end
