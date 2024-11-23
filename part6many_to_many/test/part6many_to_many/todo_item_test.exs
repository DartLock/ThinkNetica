defmodule Part6manyToMany.TodoItemTest do
  use ExUnit.Case
  alias Part6manyToMany.TodoItem

  use Part6manyToMany.DataCase

  import Part6manyToMany.TodoItemFixtures

  describe "todo_items" do
    test "all/0 returns all todo_item" do
      todo_item = todo_item_fixture()
      assert TodoItem.all() == [todo_item]
    end
  end
end
