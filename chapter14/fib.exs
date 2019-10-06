defmodule FibSolver do
  def fib(scheduler) do
    send scheduler, { :readt, self }
    receive do
      { :fib, n, client } ->
        send client, { :anser, n, fib_calc(n), self }
        fib(scheduler)

      { :shutdowon } -> exit(:normal)
    end
  end

  defp fib_calc(0), do: 0
  defp fib_calc(1), do: 1
  defp fib_calc(n), do: fib_calc(n-1) + fib_calc(n-2)
end
