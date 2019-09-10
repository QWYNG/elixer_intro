defmodule QuickSort do

#  def guess(actual, a..b, pivot \\ pivot_number(a, b)) したい

  def guess(actual, a..b) do
    guess(actual, a..b, pivot_number(a, b))
  end

  def guess(actual, _a.._b, pivot) when actual == pivot do
    IO.puts actual
  end

  def guess(actual, a.._b, pivot) when actual < pivot do
    IO.puts("Is it #{ pivot }?")
    guess(actual, a..(pivot - 1), pivot_number(a, (pivot - 1)))
  end

  def guess(actual, _a..b, pivot) when actual > pivot do
    IO.puts("Is it #{ pivot }?")
    guess(actual, (pivot + 1)..b, pivot_number((pivot + 1), b))
  end

  def pivot_number(a, b) do
    div((b - a), 2) + a
  end
end

QuickSort.guess(273, 1..1000)
