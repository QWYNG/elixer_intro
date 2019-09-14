defmodule PrimeNumber do
  def span(from, to = from) do
    [to | []]
  end

  def span(from, to) do
    [ from | span(from + 1, to) ]
  end

  def generate_prime_number_until(n) do
    for x <- span(2, n), prime_number?(x), do: x
  end

  def prime_number?(n) do
    if n <= 2 do
      false
    else
      try_prime_rem(span(3, n), :math.sqrt(n) |> Kernel.trunc )
    end
  end

  def try_prime_rem([ head | tail], n) when n <= head do
    true
  end

  def try_prime_rem([ head | tail], n) when n > head do
    if rem(n, head) == 0 do
      false
    else
      try_prime_rem(tail, n)
    end
  end
end
