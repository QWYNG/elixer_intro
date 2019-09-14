defmodule MyEnum do
  def all?([], _func) do
    true
  end
  def all?([head | tail], func) do
    if func.(head) do
      all?(tail, func)
    else
      false
    end
  end

  def each([], _func) do
    []
  end

  def each([head | tail], func) do
    func.(head)
    each(tail, func)
  end

  def filter([], _func) do
    []
  end

  def filter([head | tail], func) do
    if func.(head) do
      [ head | filter(tail, func)]
    else
      filter(tail, func)
    end
  end

  def split(list, n) do
    _split(list, n, [])
  end

  defp _split(list, n, split_array) when n == 0 do
    [split_array, list]
  end

  defp _split([head | tail], n, split_array) when n > 0 do
    array = split_array ++ [head]
    _split(tail, n - 1, array)
  end

  def take(list, n) do
    _take(list, n, [])
  end

  defp _take(_list, n, split_array) when n == 0 do
    split_array
  end

  defp _take([head | tail], n, split_array) when n > 0 do
    array = split_array ++ [head]
    _take(tail, n - 1, array)
  end
end

list = Enum.to_list(1..5)
IO.inspect MyEnum.all?(list, &(&1 < 4))
IO.inspect MyEnum.filter(list, &(&1 > 2))
IO.inspect MyEnum.split(list, 3)
IO.inspect MyEnum.take(list, 3)



