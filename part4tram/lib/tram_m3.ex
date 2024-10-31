defmodule TramM3 do
  use GenServer

  @states %{
    doors_closed: {:doors_on, :doors_off, :drive},
    driving: {:doors_off, :drive, :stop},
    stopped: {:drive, :stop, :doors_on},
    doors_opened: {:stop, :doors_on, :doors_off}
  }
  def get_states(), do: @states
  def tram_state_info(current_state), do: @states[current_state]

  @tram_stops %{
    first_street: "Kingston Ave / Saint Djonson Place",
    second_street: "Kingston Ave / Stereling Place",
    third_street: "Kingston Ave / Bergen Street",
    fourth_street: "Olbany Ave / Saint Djonson Place",
    fifth_street: "Olbany Ave / Stereling Place",
    sixth_street: "Olbany Ave / Bergen Street"
  }
  def get_tram_stops(), do: @tram_stops
  def tram_stop_name(current_stop), do: @tram_stops[current_stop]

  def to_doors_off(:doors_opened), do: :doors_closed
  def to_doors_off(_), do: :error
  def to_drive(:doors_closed), do: :driving
  def to_drive(_), do: :error
  def to_stop(:driving), do: :stopped
  def to_stop(_), do: :error
  def to_doors_on(:stopped), do: :doors_opened
  def to_doors_on(_), do: :error

  def next_state({street, state} = {street, :doors_closed}), do: {street, to_drive(state)}
  def next_state({street, state} = {street, :driving}), do: {next_street(street), to_stop(state)}
  def next_state({street, state} = {street, :stopped}), do: {street, to_doors_on(state)}
  def next_state({street, state} = {street, :doors_opened}), do: {street, to_doors_off(state)}
  def next_state(_), do: :error

  defp next_street(:first_street), do: :second_street
  defp next_street(:second_street), do: :third_street
  defp next_street(:third_street), do: :fourth_street
  defp next_street(:fourth_street), do: :fifth_street
  defp next_street(:fifth_street), do: :sixth_street
  defp next_street(:sixth_street), do: :first_street
  defp next_street(_), do: :error

  @doc """
  ## Examples
      iex> TramM3.start(:first_street)
      {:ok, pid}
  """
  def start(first_tram_stop), do: GenServer.start_link(__MODULE__, {first_tram_stop, :stopped}, name: __MODULE__)

  @doc """
  ## Examples
      iex> TramM3.start(:first_street); cs = TramM3.current(pid)
      {:first_street, :stopped}
  """
  def current(), do: GenServer.call(__MODULE__, :current)

  @doc """
  ## Examples
      iex> TramM3.start(:first_street)
      {:ok, pid}
  """
  def next(), do: GenServer.cast(__MODULE__, {:next, next_state(current())})

  @doc """
  ## Examples
      iex> TramM3.stop(:first_street)
      {:ok}
  """
  def stop(), do: GenServer.cast(__MODULE__, {:next, :stop})

  @impl true
  def init({first_tram_stop, start_state}), do: {:ok, {first_tram_stop, start_state}}

  @impl true
  def handle_call(:current, _from, state) do
    case state do
      {street, tram_state} -> {:reply, {street, tram_state}, state}
      :stop -> {:reply, {:terminating}, state}
      :error -> {:reply, {:error, :terminated}, state}
    end
  end

  @impl true
  def handle_cast({:next, new_state}, _), do: {:noreply, new_state}

  @impl true
  def handle_cast({:stop, _}, _), do: {:noreply, :terminate}
end
