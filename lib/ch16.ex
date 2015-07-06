defmodule Ch16 do

  defmodule MyStack do
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
    def handle_call(:pop, _from, stack) do
      case stack do
        [] -> {:stop, :empty, stack}
        [ head | tail ] -> {:reply, head, tail} 
      end
    end

    #OTP-Servers-2
    def handle_cast({:push, value}, stack) do
      {:noreply, [ value | stack]}
    end

    #OTP-Servers-5
    def terminate(:empty, _) do
      IO.puts "The stack is empty. Quitting..." 
    end
  end
end
