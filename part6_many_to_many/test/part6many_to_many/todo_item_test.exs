defmodule Part6manyToMany.TodoItemTest do
  use ExUnit.Case
  alias Part6manyToMany.TodoItem
  alias Part6manyToMany.Debug
  use Part6manyToMany.DataCase

  describe "todo_items" do
    test "all/0 returns all todo_item" do
      {:ok, todo_item} = TodoItem.create(%{desc: "First item"})

      assert TodoItem.all() == [todo_item]
    end
  end
end
