defmodule TramM3Test do
  use ExUnit.Case
  # doctest Tram

  alias TramM3.Debug

  test "greets the world" do
    assert {:ok, pid} = TramM3.start(:first_street)

    # Debug.show("TEST #1", [{"pid", pid}])

    current_state = TramM3.current(pid)

    {current_street, state} = current_state

    Debug.show("TEST #2", [{"current_state", current_state}, {"current_street", current_street}])

    state_info = TramM3.get_tram_state_info(state)
    street_name = TramM3.get_tram_stop_name(current_street)

    Debug.show("TEST #3", [{"state", state}, {"state_info", state_info}, {"street_name", street_name}])

    # assert Tram.hello() == :world
  end
end
