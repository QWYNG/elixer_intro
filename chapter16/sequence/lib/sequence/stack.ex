defmodule Sequence.StackServer do
  use GenServer

  def start_link default_stack do
    GenServer.start_link(__MODULE__, default_stack, name: :Stack)
  end
  
  def push_stack element do
    GenServer.cast :Stack, {:push, element}
  end
  
  def handle_call({:create, [head | tail]}, _, _) do
    stack = [head | tail]
    {:reply, stack, stack}
  end

  def handle_call(:pop, _from, current_stack) do
    {poped, poped_stack} = List.pop_at(current_stack, 0)
    {:reply, poped, poped_stack}
  end

  def handle_cast({:push, element}, current_stack) when is_integer(element) do
    System.halt(:shutdown)
  end

  def handle_cast({:push, element}, current_stack) do
    {:noreply, [element | current_stack]}
  end
  
  def terminate(reason, state) do
    IO.inspect(reason)
  end
end
