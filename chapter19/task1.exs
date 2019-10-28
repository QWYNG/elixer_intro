defmodule Fib do
	def of(0), do: 0
	def of(1), do: 1
	def of(n), do: Fib.of(n-1) + Fib.of(n - 2)
end

IO.puts("start the task")
worker = Task.async(fn -> Fib.of(30) end)
IO.puts("Do something else")
IO.puts("wait for task")
result =  Task.await(worker)

IO.puts("task result is #{result}")
