defmodule Part2Echo do
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    {:ok, %{}}
  end

  def handle_call(:ping, _from, state) do
    {:reply, {:pong, node()}, state}
  end

  def ping do
    GenServer.call(__MODULE__, :ping)
  end
end
