defmodule Part2EchoTest do
  use ExUnit.Case
  doctest Part2Echo

  test "got message" do
    ping_word = "Ping!"
    pong_word = "Pong!"
    expected_message = "#{ping_word} #{pong_word}"

    {:ok, sender_pid} = Part2Echo.start_link()
    listener_pid = Part2Echo.Listener.run(sender_pid)

    Part2Echo.push(listener_pid, ping_word)

    Process.sleep(400)

    message_from_listener = Part2Echo.pop(sender_pid)

    assert message_from_listener == expected_message
  end
end
