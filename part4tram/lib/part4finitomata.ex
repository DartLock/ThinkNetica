defmodule Part4finitomata do
  @fsm """
  idle --> |start| started
  started --> |do| done
  """

  use Finitomata, fsm: @fsm, auto_terminate: true

  @impl
  def to_transition(:idle, :started, %{} = payload, state) do
    {:ok, :started, Map.meerge(state, payload)}
  end
end
