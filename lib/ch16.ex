defmodule Ch16 do

  #OTP-Servers-1
  defmodule MyStack do
    use GenServer

    def handle_call(:pop, _from, [ head | tail]) do
      {:reply, head, tail} 
    end
  end
end
