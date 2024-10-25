defmodule TramM3 do
  use GenServer

  alias TramM3.Debug

  # состояния должны быть простыми в итоге, например :driving.
  # но контролировать внутри метода можно более сложными матчами
  # что бы правильно переходить из строго одного состояния в строго следующее.
  # например, трамвай не может ехать с открытыми дверями.

  @states {
    {:doors_closed, {:doors_on, :doors_off, :drive}},
    {:driving, {:doors_off, :drive, :stop}},
    {:stopped, {:drive, :stop, :doors_on}},
    {:doors_opened, {:stop, :doors_on, :doors_off}}
  }
  def get_states(), do: @states
  def get_tram_state_info(current_state) do
    {{current_state, state_info}, _, _, _} = @states
    state_info
  end
  def get_tram_state_info(_), do: :error

  @tram_stops {
    {:first_street, "Kingston Ave / Saint Djonson Place"},
    {:second_street, "Kingston Ave / Stereling Place"},
    {:third_street, "Kingston Ave / Bergen Street"},
    {:fourth_street, "Olbany Ave / Saint Djonson Place"},
    {:fifth_street, "Olbany Ave / Stereling Place"},
    {:sixth_street, "Olbany Ave / Bergen Street"}
  }
  def get_tram_stops(), do: @tram_stops
  def get_tram_stop_name(current_stop) do
    {{current_stop, stop_street_name}, _, _, _, _, _} = @tram_stops
    stop_street_name
  end
  def get_tram_stop_name(_), do: :error

  def to_doors_off(:doors_opened), do: :doors_closed
  def to_doors_off(_), do: :error
  def to_drive(:doors_closed), do: :driving
  def to_drive(_), do: :error
  def to_stop(:driving), do: :stopped
  def to_stop(_), do: :error
  def to_doors_on(:stopped), do: :doors_opened
  def to_doors_on(_), do: :error

  def set_next_state(state = :doors_opened), do: to_doors_off(state)
  def set_next_state(state = :doors_closed), do: to_drive(state)
  def set_next_state(state = :driving), do: to_stop(state)
  def set_next_state(state = :stopped), do: to_doors_on(state)
  def set_next_state(_), do: :error

  def set_next_street(:first_street), do: :second_street
  def set_next_street(:second_street), do: :third_street
  def set_next_street(:third_street), do: :fourth_street
  def set_next_street(:fourth_street), do: :fifth_street
  def set_next_street(:fifth_street), do: :sixth_street
  def set_next_street(:sixth_street), do: :first_street
  def set_next_street(_), do: :error

  def start(first_tram_stop \\ :first_street) do
    initial_state = {first_tram_stop, :stopped}

    Debug.show(".start_link #2",[{"initial_state", initial_state}])

    GenServer.start_link(__MODULE__, initial_state)
  end

  def current(pid) do
    current_state = GenServer.call(pid, :current)
    #Debug.show("GenServer.call .current",[{"current_state", current_state}])
    current_state
  end

  def next(pid, state) do
    # need case transition
    GenServer.cast(pid, {:next, state})
  end

  def terminate(pid, :terminate) do
    GenServer.cast(pid, {:terminate})
  end

  @impl true
  def init({first_tram_stop, start_state}) do
    #Debug.show(".init",[{"first_tram_stop", first_tram_stop}, {"start_state", start_state}])

    {:ok, {first_tram_stop, start_state}}
  end

  @impl true
  def handle_call(:current, _from, state) do
    #Debug.show(".handle_call :current #1",[{"state", state}])

    {street, tram_state} = state

    #Debug.show(".handle_call :current #2",[{"street", street}, {"state", state}])

    {:reply, {street, tram_state}, ""}
  end

  @impl true
  def handle_cast({:next, element}, state) do
    new_state = [element | state]

    #Debug.show(".handle_cast :push",[{"new_state", new_state}, {"element", element}, {"state", state}])

    {:noreply, new_state}
  end

  @impl true
  def handle_cast({:terminate, element}, state) do
    new_state = [element | state]

    #Debug.show(".handle_cast :terminate",[{"new_state", new_state}, {"element", element}, {"state", state}])

    {:noreply, :terminate}
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
