defmodule Ch14 do
  import :timer, only: [ sleep: 1 ]
  
  #WorkingWithMultipleProcesses-3,4,5
  defmodule Ex do
    def send_msg(parent) do
      send parent, "message from child."
      raise "exception from child" #WorkingWithMultipleProcesses-4
      #exit(:boom) #WorkingWithMultipleProcesses-3
    end
  
    def run do
      #spawn_link(Ex, :send_msg, [self]) #WorkingWithMultipleProcesses-5
      spawn_monitor(Ex, :send_msg, [self])

      IO.puts "start to sleep"
      sleep 500
      IO.puts "wake up"

      handle_msg
    end

    def handle_msg do
      receive do
        msg -> IO.puts "MESSAGE RECEIVED: #{inspect msg}"
        handle_msg
      end
    end
  end
end
