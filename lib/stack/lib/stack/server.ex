defmodule Stack.Server do
  use GenServer

  #OTP-Servers-3,4
  def start_link(stack) do
    GenServer.start_link(__MODULE__, stack, name: __MODULE__)
  end

  def pop do
    GenServer.call(__MODULE__, :pop)
  end

  def push(value) do
    GenServer.cast(__MODULE__, {:push, value})
  end

  #OTP-Servers-1
  def handle_call(:pop, _from, {[head | tail], stash_pid}) do
    {:reply, head, {tail, stash_pid}} 
  end

  #OTP-Servers-2
  def handle_cast({:push, value}, {stack, stash_pid}) do
    {:noreply, {[ value | stack], stash_pid}}
  end

  #OTP-Servers-5
  def terminate(_reason, {stack, stash_pid}) do
    Stack.Stash.save_value stash_pid, stack
  end

  def init(stash_pid) do
    current_stack = Stack.Stash.get_value stash_pid
    {:ok, {current_stack, stash_pid}}
  end
end
