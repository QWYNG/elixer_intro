defmodule Sequence.StackServer do
  use GenServer

  def start_link stash_pid do
    GenServer.start_link(__MODULE__, stash_pid, name: :Stack)
  end
  
  def pop do
    GenServer.call :Stack, :pop
  end
  
  def push_stack element do
    GenServer.cast :Stack, {:push, element}
  end
  
  def init(stash_pid) do
    current_stack = Sequence.Stash.get_value stash_pid
    {:ok, {current_stack, stash_pid}}
  end

  def handle_call(:pop, _from,  {current_stack, stash_pid}) do
    {poped, poped_stack} = List.pop_at(current_stack, 0)
    {:reply, poped, {poped_stack, stash_pid }}
  end

  def handle_cast({:push, element},  {current_stack, stash_pid}) when is_integer(element) do
    System.halt(:shutdown)
  end

  def handle_cast({:push, element}, {current_stack, stash_pid}) do
    {:noreply, { [element | current_stack], stash_pid}}
  end
  
  def terminate(_reason, {current_stack, stash_pid}) do
    Sequence.Stash.save_value stash_pid, current_stack
  end
end
