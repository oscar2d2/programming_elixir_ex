defmodule Ch6 do
#Exercise: ModulesAndFunctions-6
  defmodule Chop do
    def guess(actual, low..high) do
      mid = div(low + high, 2)
      IO.puts "Is It #{mid}"
      _guess(mid, actual, low..high)
    end

    defp _guess(g, actual, _low.._high) when g == actual do
        IO.puts actual
    end

    defp _guess(g, actual, low.._high) when g > actual do
      guess(actual, low..(g-1))
    end

    defp _guess(g, actual, _low..high) when g < actual do
      guess(actual, (g+1)..high)
    end
  end

  Chop.guess(273, 1..1000)
end
