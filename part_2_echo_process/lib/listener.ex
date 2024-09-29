defmodule Part2Echo.Listener do
  alias Part2Echo.Debug

  @moduledoc """
  Part2Echo.Listener.run(sender_pid).

  Запускает процесс(основной), в процесс передается коллбэк слушатель и PID процесса который будет посылать сообщения слушателю.

  Для начала необходимо инициализировать процесс который будет посылать сообщения:
  ```
  {:ok, sender_pid} = Part2Echo.start_link()
  ```

  Далее нужно запустить процесс слушателеь и передать ему PID(`sender_pid`) посылающего процесса
  и получить от него PID(`listener_pid`) слушателя:
  ```
  listener_pid = Part2Echo.Listener.run(sender_pid)
  ```

  Теперь оба просса готовы для обмено сообщениями и можно из основного процесса послать сообщение:
  ```
  Part2Echo.push(listener_pid, "Ping!")
  ```

  Слушатель примет сообщение "Ping!" и запишет этому сообщение "Pong!".
  Далее новое сообщение "Ping! Pong!" вышлет основному серверу.

  Сообщение "Ping! Pong!" от слушателя можно будет извлечь:
  ```
  message_from_listener = Part2Echo.pop(sender_pid)
  ```
  Переменная `message_from_listener` будет содержать "Ping! Pong!".
  """

  @doc """

  Запускает процесс слушателя.
  - в качестве аргумента необходимо передать PID основного процесса, того который будет посылать слушателю сообщения.

  ## Examples
      Part2Echo.Listener.run(sender_pid)
  """

  def run(sender_pid) do
    spawn(fn -> listen(sender_pid) end)
  end

  defp listen(sender_pid) do
    receive do
      {_, {:push, message}} ->
        Part2Echo.push(sender_pid, "#{message} Pong!")

        Debug.show("receive", [{"message", message}, {"sender_pid", sender_pid}])

        listen(sender_pid)
      _ ->
        Debug.out_exit()
    end

    IO.puts("-----------------------------")
    IO.puts("Listener Stopped.")
    IO.puts("-----------------------------")
  end
end
