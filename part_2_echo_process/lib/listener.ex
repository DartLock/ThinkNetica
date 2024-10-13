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
  Part2Echo.push(listener_pid,:ping)
  ```

  Слушатель примет сообщение ":ping" и запишет этому сообщение ":ping".
  Далее новое сообщение ":pong" вышлет основному серверу.

  Сообщение ":pong" от слушателя можно будет извлечь:
  ```
  message_from_listener = Part2Echo.pop(sender_pid)
  ```
  Переменная `message_from_listener` будет содержать ":pong".
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
      {_, {:push, :ping}} ->
        Part2Echo.push(sender_pid, {:pong, node()})

        listen(sender_pid)
      _ ->
        Debug.out_exit()
    end

    IO.puts("-----------------------------")
    IO.puts("Listener Stopped.")
    IO.puts("-----------------------------")
  end
end
