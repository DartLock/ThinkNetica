defmodule TramTest do
  use ExUnit.Case

  test "next state transtition to next stop" do
    Tram.start()

    assert :stopped == Tram.current()

    Tram.next()
    assert :doors_opened == Tram.current()

    Tram.next()
    assert :doors_closed == Tram.current()

    Tram.next()
    assert :driving == Tram.current()

    Tram.next()
    assert :stopped == Tram.current()
  end

  test "error when tram process is terminated" do
    Tram.start()
    Tram.stop()
    Tram.next()

    assert Tram.current() == :terminated
  end

  test "tram in terminating state" do
    Tram.start()
    Tram.stop()

    assert Tram.current() == :terminating
  end
end
