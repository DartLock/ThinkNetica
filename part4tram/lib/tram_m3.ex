defmodule TramM3 do
  use GenServer

  alias Tram.Debug

  @states %{
    doors_closed: {:doors_on, :doors_off, :drive},
    driving: {:doors_off, :drive, :stop},
    stopped: {:drive, :stop, :doors_on},
    doors_opened: {:stop, :doors_on, :doors_off}
  }

  @tram_stops %{
    first: {:street, "Kingston Ave / Saint Djonson Place"},
    second: {:street, "Kingston Ave / Stereling Place"},
    third: {:street, "Kingston Ave / Bergen Street"},
    fourth: {:street, "Olbany Ave / Saint Djonson Place"},
    fifth: {:street, "Olbany Ave / Stereling Place"},
    sixth: {:street, "Olbany Ave / Bergen Street"}
  }

  def doors_off({:stop, :doors_on, :doors_off}), do: {:doors_on, :doors_off, :drive}
  def doors_off(_), do: :error
  def drive({:doors_on, :doors_off, :drive}), do: {:doors_off, :drive, :stop}
  def drive(_), do: :error
  def stop({:doors_off, :drive, :stop}), do: {:drive, :stop, :doors_on}
  def stop(_), do: :error
  def doors_on({:drive, :stop, :doors_on}), do: {:stop, :doors_on, :doors_off}
  def doors_on(_), do: :error

  def set_next_state(state = {:stop, :doors_on, :doors_off}), do: doors_off(state)
  def set_next_state(state = {:doors_on, :doors_off, :drive}), do: drive(state)
  def set_next_state(state = {:doors_off, :drive, :stop}), do: stop(state)
  def set_next_state(state = {:drive, :stop, :doors_on}), do: doors_on(state)
  def set_next_state(_), do: :error

  def set_next_street({:street, "Kingston Ave / Saint Djonson Place"}), do: {:street, "Kingston Ave / Stereling Place"}
  def set_next_street({:street, "Kingston Ave / Stereling Place"}), do: {:street, "Kingston Ave / Bergen Street"}
  def set_next_street({:street, "Kingston Ave / Bergen Street"}), do: {:street, "Olbany Ave / Saint Djonson Place"}
  def set_next_street({:street, "Olbany Ave / Saint Djonson Place"}), do: {:street, "Olbany Ave / Stereling Place"}
  def set_next_street({:street, "Olbany Ave / Stereling Place"}), do: {:street, "Olbany Ave / Bergen Street"}
  def set_next_street({:street, "Olbany Ave / Bergen Street"}), do: {:street, "Kingston Ave / Saint Djonson Place"}
  def set_next_street(_), do: :error

  def start_link({tram_stop, start_state} = {{:street, street}, {:drive, :stop, :doors_on}}) do
    Debug.show(".start_link",[{"first_tram_stop", tram_stop}, {"start_state", start_state}])

    GenServer.start_link(__MODULE__, {tram_stop, start_state}, name: :tram)
  end

  @impl true
  def init(start_state) do
    Debug.show(".init",[{"start_state", start_state}])

    {:ok, start_state}
  end

  def current() do
    current_street = GenServer.call(__MODULE__, :current)
    Debug.show(".current_street",[{"current_street", current_street}])
    current_street
  end

  def next(state) do
    GenServer.cast(__MODULE__, {:next, state})
  end

  @impl true
  def handle_call(:current, _from, [head | tail]) do
    Debug.show(".handle_call :current",[{"head", head}, {"tail", tail}])

    {:reply, head, tail}
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
