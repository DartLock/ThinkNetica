defmodule TramM3Test do
  use ExUnit.Case

  test "next state transtition to next stop" do
    TramM3.start(:first_street)

    assert {:first_street, :stopped} == TramM3.current()

    TramM3.next()
    assert {:first_street, :doors_opened} == TramM3.current()

    TramM3.next()
    assert {:first_street, :doors_closed} == TramM3.current()

    TramM3.next()
    assert {:first_street, :driving} == TramM3.current()

    TramM3.next()
    assert {:second_street, :stopped} == TramM3.current()
  end

  test "get street name" do
    street_name = TramM3.tram_stop_name(:first_street)
    streets = TramM3.get_tram_stops()

    assert street_name == streets[:first_street]
  end

  test "get tram stop info" do
    state_info = TramM3.tram_state_info(:stopped)
    states = TramM3.get_states()

    assert state_info == states[:stopped]
  end

  test "error when tram process is terminated" do
    TramM3.start(:first_street)
    TramM3.stop()
    TramM3.next()

    assert TramM3.current() == {:error, :terminated}
  end

  test "tram in terminating state" do
    TramM3.start(:first_street)
    TramM3.stop()

    assert TramM3.current() == {:terminating}
  end
end
