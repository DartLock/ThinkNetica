defmodule Part2Echo do
  use GenServer
  alias Part2Echo.Debug

  @moduledoc """
  Part2Echo.

  - Используется своего рода отладочная информация через модуль Part2Echo.Debug,
    что бы следить за ходом выполнения передачи и получения сообщений.

  Основной процесс. Процесс передает сообщения слушателю, а так же принимает от слушателя ответы.

  Основной процесс должен начинаться с вызова `start_link()`:
  ```
  {:ok, sender_pid} = Part2Echo.start_link()
  ```

  `sender_pid` используется для передачи слушателю в `Part2Echo.Listener.run(sender_pid)`
  """

  @doc """
  Функция запускает основной процесс и возвращает кортеж вида `{:ok, pid}`.

  ## Examples
      {:ok, sender_pid} = Part2Echo.start_link()
  """

  def start_link() do
    GenServer.start_link(__MODULE__, "")
  end

  @doc """
  Функция асинхронно передает сообщение слушателю.

  - В качестве первого аргумента нужно передать PID слушателя.
  - PID слушателя возвращается при вызове `listener_pid = Part2Echo.Listener.run(sender_pid)`

  - Вторым аргументом передается сообщение например "Ping!"

  ## Examples
      Part2Echo.push(listener_pid)
  """
  def push(pid, message) do
    GenServer.cast(pid, {:push, message})
  end

  @doc """
  Функция синхронно получает ответ от слушателя `Part2Echo.Listener`.

  - В качестве первого аргумента нужно передать PID основного процесса.
  - Возвращает ответ от слушателя, после запроса через функцию `push`.

  ## Examples
      response = Part2Echo.pop(sender_pid)
  """
  def pop(pid) do
    GenServer.call(pid, :pop)
  end

  # server

  @impl true
  def init(state) do
    elements = String.split(state, ";", trim: true)
    {:ok, elements}
  end

  @impl true
  def handle_cast({:push, element}, state) do
    new_state = [element | state]
    {:noreply, new_state}
  end

  @impl true
  def handle_call(:pop, _from, state) do
    [to_caller | new_state] = state

    Debug.show("handle_call :pop", [{"state", state}, {"new_state", new_state}, {"to_caller", to_caller}])

    {:reply, to_caller, new_state}
  end
end
