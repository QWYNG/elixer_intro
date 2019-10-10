defmodule Ticker do
	@interval 2000
	@name :ticker
	
	def start do
		pid = spawn(__MODULE__, :generator, [[], 0])
		:global.register_name(@name, pid)
	end
	
	def register(client_pid) do
		send :global.whereis_name(@name), { :register, client_pid }
	end
	
	def generator(clients, n) do
		receive do
			{ :register, pid } ->
				IO.puts("registering #{inspect pid}")
				generator([pid|clients], n)
		after @interval ->
			Enum.reverse(clients)
			|> Enum.at(n, List.last(clients))
			|> tick
			
			if Enum.count(clients) <= n do
				generator(clients, 1)
			else
				generator(clients, n + 1)
			end
		end
	end
	
	def tick(pid) when pid == nil do
		IO.puts("tick")
	end
	
	def tick(pid) do
		IO.puts("tick")
		send(pid, { :tick })
	end
end

defmodule Client do
	def start(n) do
		pid = spawn(__MODULE__, :receiver, [n])
		Ticker.register(pid)
	end
	
	def receiver(n) do
		receive do
			{ :tick } ->
				IO.puts("Gotta tick! #{n}")
				receiver n
		end
	end
end
