defmodule Lesson01CalcTest do
  use ExUnit.Case
  doctest Lesson01Calc

  test "add operator return 210" do
    assert Lesson01Calc.compute(105, 105, "+") == {:ok, 210}
  end

  test "minus operator return 0" do
    assert Lesson01Calc.compute(105, 105, "-") == {:ok, 0}
  end

  test "multiple operator return 11050" do
    assert Lesson01Calc.compute(105, 105, "*") == {:ok, 11025}
  end

  test "divide operator return 10" do
    assert Lesson01Calc.compute(100, 10, "/") == {:ok, 10}
  end

  test "return ok with question Where i am?" do
    assert Lesson01Calc.compute("Where i am?") == {:ok, "This is a simple calculator!"}
  end

  test "return ok with question Who is here?" do
    assert Lesson01Calc.compute("Who is here?") == {:ok, "Here is the Calulator!"}
  end

  test "return error with Unknown action" do
    assert Lesson01Calc.compute("What?") == {:error, "Unknown action!"}
  end

  test "return error with unknown operator" do
    assert Lesson01Calc.compute(1, 2, ".") == {:error, "Unknown operator!"}
  end
end
