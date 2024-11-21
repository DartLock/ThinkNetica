defmodule Part6manyToMany.TodoListItemTest do
  use ExUnit.Case
  alias Part6manyToMany.TodoListItem
  alias Part6manyToMany.TodoListItemRepo

  use Part6manyToMany.DataCase

  import Part6manyToMany.TodoListItemFixtures
  import Part6manyToMany.TodoListFixtures
  import Part6manyToMany.TodoItemFixtures

  describe "relations" do
    test "all/0 returns all relations" do
      list = todo_list_fixture()
      item = todo_item_fixture()

      {:ok, relation} = Part6manyToMany.TodoListItem.create(%{todo_item: item, todo_list: list})

      exists_relations = TodoListItem.all()

      assert exists_relations == [relation]
    end

    test "get/1 returns relation by id" do
      list = todo_list_fixture()
      item = todo_item_fixture()

      {:ok, relation} = Part6manyToMany.TodoListItem.create(%{todo_item: item, todo_list: list})

      exists_relations = TodoListItem.all()

      assert exists_relations == [relation]
    end
  end
end
