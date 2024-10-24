defmodule TramM3Test do
  use ExUnit.Case
  # doctest Tram

  alias TramM3.Debug

  test "greets the world" do
    assert {:ok, pid} = TramM3.start()

    Debug.show("TEST #1", [{"pid", pid}])

    state = TramM3.current(pid)

    Debug.show("TEST #2", [{"state", state}])

    # assert Tram.hello() == :world
  end
end
