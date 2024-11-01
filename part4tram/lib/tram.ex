defmodule Tram do
  use GenServer

  @states [
    :doors_opened,
    :doors_closed,
    :driving,
    :stopped
  ]

  def get_states(), do: @states

  def next_state(:doors_opened), do: :doors_closed
  def next_state(:doors_closed), do: :driving
  def next_state(:driving), do: :stopped
  def next_state(:stopped), do: :doors_opened
  def next_state(_), do: :error

  @doc """
  ## Examples
      iex> Tram.start()
      {:ok, pid}
  """
  def start(), do: GenServer.start_link(__MODULE__, :stopped, name: __MODULE__)

  @doc """
  ## Examples
      iex> Tram.start(); cs = Tram.current()
      :stopped
  """
  def current(), do: GenServer.call(__MODULE__, :current)

  @doc """
  ## Examples
      iex> Tram.next()
      :ok
  """
  def next(), do: GenServer.cast(__MODULE__, {:next, next_state(current())})

  @doc """
  ## Examples
      iex> Tram.stop()
      :ok
  """
  def stop(), do: GenServer.cast(__MODULE__, {:next, :stop})

  @impl true
  def init(start_state), do: {:ok, start_state}

  @impl true
  def handle_call(:current, _from, state) do
    if state in @states do
      {:reply, state, state}
    else
      case state do
        :stop -> {:reply, :terminating, :stop}
        _ -> {:reply, :terminated, :error}
      end
    end
  end

  @impl true
  def handle_cast({:next, new_state}, _), do: {:noreply, new_state}

  @impl true
  def handle_cast({:stop, _}, _), do: {:noreply, :terminate}
end
