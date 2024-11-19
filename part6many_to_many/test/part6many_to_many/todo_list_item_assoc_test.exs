defmodule Part6manyToMany.TodoListItemAssocTest do
  use ExUnit.Case
  alias Part6manyToMany.TodoListItemAssoc
  alias Part6manyToMany.TodoListItemAssocRepo

  use Part6manyToMany.DataCase

  import Part6manyToMany.TodoListItemAssocFixtures
  import Part6manyToMany.TodoListFixtures
  import Part6manyToMany.TodoItemFixtures

  describe "assocs" do
    test "all/0 returns all assocs" do
      list = todo_list_fixture()
      item = todo_item_fixture()

      {:ok, assocs} = Part6manyToMany.TodoListItemAssoc.create_assoc(%{todo_item: item, todo_list: list})

      exists_assocs = TodoListItemAssoc.all()

      assert exists_assocs == [assocs]
    end

    test "get/1 returns assoc by id" do
      list = todo_list_fixture()
      item = todo_item_fixture()

      {:ok, assocs} = Part6manyToMany.TodoListItemAssoc.create_assoc(%{todo_item: item, todo_list: list})

      exists_assocs = TodoListItemAssoc.all()

      assert exists_assocs == [assocs]
    end
  end
end
