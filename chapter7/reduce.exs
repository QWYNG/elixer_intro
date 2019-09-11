defmodule MyList do
  def mapsum([head | tail], func) do
    _mapsum(tail, func, func.(head))
  end

  defp _mapsum([], _func, total), do: total
  defp _mapsum([head | tail], func, total) do
    _mapsum(tail, func, total + func.(head))
  end

  def max([head | tail]) do
    _max(tail, head)
  end

  defp _max([], max), do: max
  defp _max([head | tail], max) when head > max do
    _max(tail, head)
  end
  defp _max([head | tail], max) when head <= max do
    _max(tail, max)
  end

  def caesar([head | tail], n) do
    _caesar([head | tail], n)
  end

  defp _caesar([], _n), do: []
  defp _caesar([head | tail], n) when head + n <= 123 do
    [head + n | _caesar(tail, n)]
  end
  defp _caesar([head | tail], n) when head + n > 123 do
    [head + n - 26 | _caesar(tail, n)]
  end

  def span(from, to = from) do # toにマッチしてからfromにマッチするかたしかめてる？　なんか本と挙動違う気がする
    [to | []]
  end

  def span(from, to) do
    [ from | span(from + 1, to) ]
  end
end

IO.puts(MyList.mapsum([1, 2, 3], &(&1 * &1)))
IO.puts(MyList.max([1, 3, 6, 8, 3]))
IO.puts(MyList.caesar('ryvkve', 13))
MyList.span(5, 12)
