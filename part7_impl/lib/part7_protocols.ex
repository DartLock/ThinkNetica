defmodule Part7Protocols do
  @behaviour Part7Protocols.Protocols.InputToList

  defimpl Part7Protocols.Protocols.Lister, for: BitString do
    def to_list(input) when is_bitstring(input) do
      Part7Protocols.input_to_list(input)
    end
  end

  defimpl Part7Protocols.Protocols.Lister, for: Integer do
    def to_list(input) when is_integer(input) do
      Part7Protocols.input_to_list("#{input}")
    end
  end

  defimpl Part7Protocols.Protocols.Lister, for: Float do
    def to_list(input) when is_float(input) do
      Part7Protocols.input_to_list("#{input}")
    end
  end

  defimpl Part7Protocols.Protocols.Lister, for: Map do
    def to_list(input) when is_map(input), do: Map.to_list(input)
  end

  @impl
  def input_to_list(input) when is_bitstring(input) do
    String.splitter(input, "", trim: true) |> Enum.take(String.length(input))
  end
end
