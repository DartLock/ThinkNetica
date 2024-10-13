defmodule Part2EchoTest do
  use ExUnit.Case
  doctest Part2Echo

  test "got message" do
    expected_message = {:pong, :nonode@nohost}

    Part2Echo.start_link()
    result = Part2Echo.ping()

    assert result == expected_message
  end
end
