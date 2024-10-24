defmodule TramM3 do
  use GenServer

  alias TramM3.Debug

  # состояния должны быть простыми в итоге.
  # но контролировать внутри метода можно более сложными матчами

  @states {
    :doors_closed, {:doors_on, :doors_off, :drive},
    :driving, {:doors_off, :drive, :stop},
    :stopped, {:drive, :stop, :doors_on},
    :doors_opened, {:stop, :doors_on, :doors_off}
  }

  @tram_stops {
    :first_street, "Kingston Ave / Saint Djonson Place",
    :second_street, "Kingston Ave / Stereling Place",
    :third_street, "Kingston Ave / Bergen Street",
    :fourth_street, "Olbany Ave / Saint Djonson Place",
    :fifth_street, "Olbany Ave / Stereling Place",
    :sixth_street, "Olbany Ave / Bergen Street"
  }

  def to_doors_off({:stop, :doors_on, :doors_off}), do: {:doors_on, :doors_off, :drive}
  def to_doors_off(_), do: :error
  def to_drive({:doors_on, :doors_off, :drive}), do: {:doors_off, :drive, :stop}
  def to_drive(_), do: :error
  def to_stop({:doors_off, :drive, :stop}), do: {:drive, :stop, :doors_on}
  def to_stop(_), do: :error
  def to_doors_on({:drive, :stop, :doors_on}), do: {:stop, :doors_on, :doors_off}
  def to_doors_on(_), do: :error

  def set_next_state(state = {:stop, :doors_on, :doors_off}), do: to_doors_off(state)
  def set_next_state(state = {:doors_on, :doors_off, :drive}), do: to_drive(state)
  def set_next_state(state = {:doors_off, :drive, :stop}), do: to_stop(state)
  def set_next_state(state = {:drive, :stop, :doors_on}), do: to_doors_on(state)
  def set_next_state(_), do: :error

  def set_next_street({:street, "Kingston Ave / Saint Djonson Place"}), do: {:street, "Kingston Ave / Stereling Place"}
  def set_next_street({:street, "Kingston Ave / Stereling Place"}), do: {:street, "Kingston Ave / Bergen Street"}
  def set_next_street({:street, "Kingston Ave / Bergen Street"}), do: {:street, "Olbany Ave / Saint Djonson Place"}
  def set_next_street({:street, "Olbany Ave / Saint Djonson Place"}), do: {:street, "Olbany Ave / Stereling Place"}
  def set_next_street({:street, "Olbany Ave / Stereling Place"}), do: {:street, "Olbany Ave / Bergen Street"}
  def set_next_street({:street, "Olbany Ave / Bergen Street"}), do: {:street, "Kingston Ave / Saint Djonson Place"}
  def set_next_street(_), do: :error

  def start(%{first: first_stop} \\ %{first: @tram_stops.first}) do
    initial_state = {first_stop, @states.stopped}

    Debug.show(".start_link #2",[{"initial_state", initial_state}])

    GenServer.start_link(__MODULE__, initial_state)
  end

  def current(pid) do
    current_street = GenServer.call(pid, :current)
    Debug.show(".current_street",[{"current_street", current_street}])
    current_street
  end

  def next(pid, state) do
    # need case transition
    GenServer.cast(pid, {:next, state})
  end

  @impl true
  def init({tram_stop, start_state}) do
    Debug.show(".init",[{"tram_stop", tram_stop}, {"start_state", start_state}])

    {:ok, {tram_stop, start_state}}
  end

  @impl true
  def handle_call(:current, _from, current_state) do
    Debug.show(".handle_call :current #1",[{"current_state", current_state}])

    {{:street, street}, {:state, state}} = current_state

    Debug.show(".handle_call :current #2",[{"street", street}, {"state", state}])

    {:reply, current_state}
  end

  @impl true
  def handle_cast({:next, element}, state) do
    new_state = [element | state]

    Debug.show(".handle_cast :push",[{"new_state", new_state}, {"element", element}, {"state", state}])

    {:noreply, new_state}
  end

  # def transition({previous, current, next} = state) do
  #   Debug.show(".transition 1",[{"previous", previous}, {"current", current}, {"next", next}, {"state", state}])
  #
  #   case {previous, current, next} do
  #     {:doors_on, :doors_off, :drive} -> {:doors_off, :drive, :stop}
  #     {:doors_off, :drive, :doors_on} -> {:drive, :doors_on, :doors_off}
  #     {:drive, :doors_on, :doors_off} -> {:doors_on, :doors_off, :drive}
  #     _ -> {:error}
  #   end
  # end
end
