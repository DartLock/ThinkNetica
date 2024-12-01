defmodule Part7ProtocolsTest do
  use ExUnit.Case
  doctest Part7Protocols

  test "string to list" do
    expect_list = ["H", "e", "l", "l", "o", "F", "r", "o", "m", "H", "e", "l", "l"]

    assert Part7Protocols.Protocols.Lister.to_list("HelloFromHell") == expect_list
  end

  test "integer to list" do
    expect_list = ["1", "2", "3"]

    assert Part7Protocols.Protocols.Lister.to_list(123) == expect_list
  end

  test "float to list" do
    expect_list = ["1", "2", "3", ".", "5"]

    assert Part7Protocols.Protocols.Lister.to_list(123.5) == expect_list
  end

  test "map to list" do
    expect_list = [a: "first", b: "second"]

    assert Part7Protocols.Protocols.Lister.to_list(%{a: "first", b: "second"}) == expect_list
  end
end
