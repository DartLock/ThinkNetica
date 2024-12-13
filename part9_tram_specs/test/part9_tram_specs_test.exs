defmodule Part9TramSpecsTest do
  use ExUnit.Case
  doctest Part9TramSpecs

  test "next state transtition to next stop" do
    Part9TramSpecs.start()



    assert :stopped == Part9TramSpecs.current()

    Part9TramSpecs.next()
    assert :doors_opened == Part9TramSpecs.current()

    Part9TramSpecs.next()
    assert :doors_closed == Part9TramSpecs.current()

    Part9TramSpecs.next()
    assert :driving == Part9TramSpecs.current()

    Part9TramSpecs.next()
    assert :stopped == Part9TramSpecs.current()
  end

  test "error when tram process is terminated" do
    Part9TramSpecs.start()
    Part9TramSpecs.stop()
    Part9TramSpecs.next()

    assert Part9TramSpecs.current() == :terminated
  end

  test "tram in terminating state" do
    Part9TramSpecs.start()
    Part9TramSpecs.stop()

    assert Part9TramSpecs.current() == :terminating
  end

  test "credo does not warning with IO inspect" do
    result = Part9TramSpecs.start()
    IO.inspect(result)
  end
end
