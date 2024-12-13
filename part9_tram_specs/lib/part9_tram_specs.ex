defmodule Part9TramSpecs do
  @moduledoc """
    Specs and Credo
  """

  use GenServer

  @states [
    :doors_opened,
    :doors_closed,
    :driving,
    :stopped
  ]

  @spec get_states() ::list()
  def get_states(), do: @states

  @doc """
  ## Examples
      iex> Part9TramSpecs.next_state(:doors_opened)
      :doors_closed
  """

  @spec next_state(state :: atom()) :: atom()
  def next_state(:doors_opened), do: :doors_closed
  def next_state(:doors_closed), do: :driving
  def next_state(:driving), do: :stopped
  def next_state(:stopped), do: :doors_opened
  def next_state(_), do: :error

  @doc """
  ## Examples
      iex> {:ok, pid} = Part9TramSpecs.start()
      {:ok, pid}
  """

  @spec start() :: {:ok, pid()}
  def start(), do: GenServer.start_link(__MODULE__, :stopped, name: __MODULE__)

  @spec current() :: atom()
  def current(), do: GenServer.call(__MODULE__, :current)

  @doc """
  ## Examples
      iex> Part9TramSpecs.start()
      iex> Part9TramSpecs.next()
      {:ok, :setting_next_state}
  """

  @spec next() :: tuple()
  def next() do
    {GenServer.cast(__MODULE__, {:next, next_state(current())}), :setting_next_state}
  end

  @doc """
  ## Examples
      iex> Part9TramSpecs.stop()
      {:ok, :stopping}
  """

  @spec stop() :: tuple()
  def stop() do
    {GenServer.cast(__MODULE__, {:next, :stop}), :stopping}
  end

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
