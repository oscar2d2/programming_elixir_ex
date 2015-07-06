defmodule Ch16 do

  defmodule MyStack do
    use GenServer

    #OTP-Servers-1
    def handle_call(:pop, _from, [ head | tail]) do
      {:reply, head, tail} 
    end

    #OTP-Servers-2
    def handle_cast({:push, value}, current_stack) do
      {:noreply, [ value | current_stack]}
    end
  end
end
