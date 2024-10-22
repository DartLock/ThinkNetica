defmodule TramM3Test do
  use ExUnit.Case
  doctest Tram

  test "greets the world" do
    assert ({:ok, pid} = TramM3.start_link()) == {:ok, pid}
    # assert Tram.hello() == :world
  end
end
