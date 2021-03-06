defmodule Ch12 do

  #ControlFlow1
  defmodule FizzBuzz do
    def upto(n) when n > 0, do: 1..n |> Enum.map(&fizzbuzz/1)

    defp fizzbuzz(n) do
      case {rem(n,3), rem(n,5)} do
        {0, 0} -> "FizzBuzz"
        {0, _} -> "Fizz"
        {_, 0} -> "Buzz"
        _ -> n 
      end
    end
  end

  #ControlFlow3
  def ok!({:ok, data}), do: data
  def ok!({_, msg}), do: raise "Not ok. #{msg}"
end
