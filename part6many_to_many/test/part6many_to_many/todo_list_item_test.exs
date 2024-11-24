defmodule Part6manyToMany.TodoListItemTest do
  use ExUnit.Case
  alias Part6manyToMany.TodoListItem
  alias Part6manyToMany.TodoList
  alias Part6manyToMany.TodoItem

  use Part6manyToMany.DataCase

  describe "relations" do
    test "create assoc" do
      {:ok, list} = TodoList.create(%{title: "List Description"})
      {:ok, item} = TodoItem.create(%{desc: "Item Title"})

      relation = TodoListItem.create(%{todo_item: item, todo_list: list})
      exists_relation = Enum.at(TodoListItem.all(), 0)

      assert exists_relation == relation

      assert list == exists_relation.todo_list
      assert item == exists_relation.todo_item
    end

    test "cascade delete by todo_item" do
      {:ok, list} = TodoList.create(%{title: "List Description"})
      {:ok, _} = TodoItem.create(%{desc: "Item Title"})

      TodoList.delete(list)

      exists_relations = TodoListItem.all()
      exists_lists = TodoList.all()

      assert exists_relations == []
      assert exists_lists == []
    end

    test "cascade delete by todo_list" do
      {:ok, _} = TodoList.create(%{title: "List Description"})
      {:ok, item} = TodoItem.create(%{desc: "Item Title"})

      TodoList.delete(item)

      exists_relations = TodoListItem.all()
      exists_items = TodoItem.all()

      assert exists_relations == []
      assert exists_items == []
    end
  end
end
