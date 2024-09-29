defmodule Part2Echo.Debug do
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
    IO.puts ""
    IO.puts "=============================================="
    IO.puts "------------- #{title} --------------"
    IO.puts "----------------------------------------------"

    for item <- elements do
      {name, value} = item
      IO.puts "#{name}:"
      IO.inspect(value, pretty: true)
      IO.puts "=============================================="
    end
  end

  def out_exit do
    IO.puts("Exiting")
  end
end
