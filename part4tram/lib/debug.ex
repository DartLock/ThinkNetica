defmodule Aircraft.Debug do
  @moduledoc """
  Данный модуль используется для вывода своего рода отладочной информации что бы следить за ходом выполнения.
  """

  @doc """

  Debug.show(string, list( touple() )).

  первым элементов передается заголовок вывода.
  в качестве второго элемента должен передаваться список картежей.
  - Будет вывод переданных элементов через цикл for.
  - Каждый перввый  элемент кортежа будет является заголовком сообщения.
  - Каждый второй элемент передается в IO.inspect.

  ## Examples
      iex> Debug.show("Title", [{"first_element", "second_element"}, {"first_element", second_element}])
      {:ok}
  """

  def show(title, elements) do
    total_head_size = 76
    show_head = fn(value) ->
      head = " #{value} "
      length_value = String.length(head)
      first_padding_length = trunc((total_head_size / 2) + ceil(length_value / 2))
      head = head |> String.pad_leading(first_padding_length, "-") |> String.pad_trailing(total_head_size, "-")

      IO.puts(head)
      IO.puts "#{add("*", "*", total_head_size)}"
    end

    IO.puts ""
    IO.puts "#{add("=", "=", total_head_size)}"
    show_head.(title)

    Enum.each(elements, fn item ->
      {key_name, value} = item

      case key_name do
        "head" -> show_head.(value)
        _ ->
          IO.puts "#{key_name}:"
          IO.inspect(value, pretty: true)
          IO.puts "#{add("-", "-", total_head_size)}"
      end
    end)

    IO.puts "#{add("=", "=", total_head_size)}"
  end

  def out_exit do
    IO.puts("Exiting")
  end

  defp add(str, sym, count) do
    str = str <> sym
    count = count - 1

    if count > 0 do
      add(str, sym, count)
    else
      str
    end
  end
end
