defmodule Part7ImplTest do
  use ExUnit.Case
  doctest Part7Impl

  test "greets the world" do
    assert Part7Impl.hello() == :world
  end
end
