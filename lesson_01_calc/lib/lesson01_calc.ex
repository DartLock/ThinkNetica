defmodule Lesson01Calc do
  @moduledoc """
  Run:
  $ iex -S mix

  Follow the documentation below.
  """

  @spec compute(number(), number(), binary()) :: {:error, binary()} | {:ok, number()}
  @doc """
  Calculating.

  ## Examples
      iex> Lesson01Calc.compute(205, 205, "+")
      {:ok, 410}

      iex> Lesson01Calc.compute(205, 205, ".")
      {:error, "Unknown operator!"}
  """
  def compute(first, second, operator) when is_number(first) and is_number(second) do
    case operator do
      "+" -> {:ok, first + second}
      "-" -> {:ok, first - second}
      "/" -> {:ok, div(first, second)}
      "*" -> {:ok, first * second}
      _ -> {:error, "Unknown operator!"}
    end
  end

  @doc """
  Questions.

  ## Examples
      iex> Lesson01Calc.compute("Where i am?")
      {:ok, "This is a simple calculator!"}

      iex> Lesson01Calc.compute("Who is here?")
      {:ok, "Here is the Calulator!"}

      iex> Lesson01Calc.compute("What?")
      {:error, "Unknown action!"}
  """
  @spec compute(any()) :: {:error, binary()} | {:ok, binary()}
  def compute(arg) do
    case arg do
      "Where i am?" -> {:ok, "This is a simple calculator!"}
      "Who is here?" -> {:ok, "Here is the Calulator!"}
      _ -> {:error, "Unknown action!"}
    end
  end
end
