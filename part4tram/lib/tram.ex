defmodule Tram do
  use GenServer

  alias tram.Debug

  STATES1 = %{
    started: {:stop, :start, :ladder_on},
    loaded: {:ladder_on, :loading, :ladder_off},
    laddered_off_to_take_off: {:loading, :ladder_off, :takeoff},
    took_of: {:ladder_off, :takeoff, :flight},
    flying: {:takeoff, :flight, :landing},
    landed: {:flight, :landing, :ladder_on},
    laddered_on: {:landing, :ladder_on, :unloading},
    unloaded: {:ladder_off, :unloading, :ladder_off},
    laddered_off_to_stop: {:unloading, :ladder_off, :stop}
  }

  STATES = [
    doors_closed: {:doors_on, :doors_off, :drive},
    driving: {:doors_off, :drive, :stop},
    stopped: {:drive, :stop, :doors_on},
    doors_opened: {:stop, :doors_on, :doors_off}
  ]

  TRAM_STOPS = [{
    :first,  "Kingston Ave / Saint Djonson Place",
    :second, "Kingston Ave / Stereling Place",
    :third,  "Kingston Ave / Bergen Street",
    :fourth, "Olbany Ave / Saint Djonson Place",
    :fifth,  "Olbany Ave / Stereling Place",
    :sixth,  "Olbany Ave / Bergen Street"
  }]

  def doors_off({:stop, :doors_on, :doors_off}), do: {:doors_on, :doors_off, :drive}
  def doors_off(_), do: :error

  def drive({:doors_on, :doors_off, :drive}), do: {:doors_off, :drive, :stop}
  def drive(_), do: :error

  def stop({:doors_off, :drive, :stop}), do: {:drive, :stop, :doors_on}
  def stop(_), do: :error

  def doors_on({:drive, :stop, :doors_on}), do: {:stop, :doors_on, :doors_off}
  def doors_on(_), do: :error

  @impl true
  def init() do
    {:ok}
  end

  def start_link(start_tram_stop) do
    GenServer.start_link(__MODULE__, [{start_tram_stop}, {:stop, :doors_on, :doors_off}], name: :tram)
  end

  def current do
    GenServer.call(__MODULE__, :pop)
  end

  @impl true
  def init(start_state) do
    Debug.show(".init",[{"start_state", start_state}])

    {:ok, start_state}
  end

  @impl true
  def handle_call(:pop, _from, state) do
    [to_caller | new_state] = state

    Debug.show(".handle_call :pop",[{"to_caller", to_caller}, {"new_state", new_state}, {"state", state}])

    {:reply, to_caller, new_state}
  end

  @impl true
  def handle_cast({:push, element}, state) do
    new_state = [element | state]

    Debug.show(".handle_cast :push",[{"new_state", new_state}, {"element", element}, {"state", state}])

    {:noreply, new_state}
  end

  def transition({previous, current, next} = state) do
    Debug.show(".transition 1",[{"previous", previous}, {"current", current}, {"next", stnextate}])
    Debug.show(".transition 2",[{"state", state}])

    case {previous, current, next} do
      {:doors_on, :doors_off, :drive} -> {:doors_off, :drive, :stop}
      {:doors_off, :drive, :doors_on} -> {:drive, :doors_on, :doors_off}
      {:drive, :doors_on, :doors_off} -> {:doors_on, :doors_off, :drive}
      _ -> {:error}
    end
  end
end
