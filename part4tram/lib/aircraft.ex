defmodule Aircraft do
  use GenServer

  alias Aircraft.Debug

  STATES = %{
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

  @impl true
  def init(stack) do
    {:ok, stack}
  end

  def start_link() do
    GenServer.start_link(__MODULE__, {:stop, :start, :ladder_on}, name: :aircraft)
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
    Debug.show(".transition",[{"previous", previous}, {"current", current}, {"next", stnextate}])

    case {previous, current, next} do
      {:ladder_off, :stop, :start} -> {:stop, :start, :ladder_on}
      {:stop, :start, :ladder_on} -> {:start, :ladder_on, :loading}
      {:ladder_on, :loading, :ladder_off} -> {:loading, :ladder_off, :takeoff}
      {:loading, :ladder_off, :takeoff} -> {:ladder_off, :takeoff, :flight}
      {:ladder_off, :takeoff, :flight} -> {:takeoff, :flight, :landing}
      {:takeoff, :flight, :landing} -> {:flight, :landing, :ladder_on}
      {:flight, :landing, :ladder_on} -> {:landing, :ladder_on, :unloading}
      {:landing, :ladder_on, :unloading} -> {:ladder_on, :unloading, :ladder_off}
      {:ladder_on, :unloading, :ladder_off} -> {:unloading, :ladder_off, :stop}
      {:unloading, :ladder_off, :stop} -> {:ladder_off, :stop, :start}
      _ -> {:error}
    end
  end

  # присоединение трапа ******
  def ladder_on({:stop, :start, :ladder_on}), do: {:start, :ladder_on, :loading}
  def ladder_on({:flight, :landing, :ladder_on}), do: {:landing, :ladder_on, :unloading}
  def ladder_on(_), do: :error

  # отсоединение трапа
  def ladder_off({:ladder_on, :unloading, :ladder_off}), do: {:unloading, :ladder_off, :stop}
  def ladder_off({:landing, :ladder_on, :ladder_off}), do: {:unloading, :ladder_off, :takeoff}
  def ladder_off(_), do: :error

  # загрузка пассажиров
  def loading({:start, :ladder_on, :loading}), do: {:ladder_on, :loading, :ladder_off}
  def loading(_), do: :error

  # выгрузка пассажиров
  def unloading({:landing, :ladder_on, :unloading}), do: {:ladder_on, :unloading, :ladder_off}
  def unloading(_), do: :error

  # взлет
  def takeoff({:loading, :ladder_off, :takeoff}), do: {:ladder_off, :takeoff, :flight}
  def takeoff(_), do: :error

  # полет
  def flight({:ladder_off, :takeoff, :flight}), do: {:takeoff, :flight, :landing}
  def flight(_), do: :error

  # приземление
  def landing({:takeoff, :flight, :landing}), do: {:flight, :landing, :ladder_on}
  def landing(_), do: :error

  # остановка процесса
  def stop({:unloading, :ladder_off, :stop}), do: {:ladder_off, :stop, :start}
  def stop(_), do: :error
end
