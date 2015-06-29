defmodule Ch11 do
  import Ch7 

  #StringsAndBinaries-1
  def printable(list), do: Enum.all?(list, &_printable/1) 
  defp _printable(c) when c >= ?\s and c <= ?~, do: true
  defp _printable(_), do: false 

  #StringsAndBinaries-2
  def anagram?(word1, word2), do: Enum.sort(word1) === Enum.sort(word2)

  #StringsAndBinaries-3
  # ['cat' | 'dog'] means ['cat'] concat with 'dog' which is a size-3 list
  # the result ['cat', 100, 111 , 103] is then same as ['cat', ?d, ?o, ?g]

  #StringsAndBinaries-4
  def calculate(list), do: list |> List.to_string |> String.split |> _calculate()
  defp _calculate([num1, "+", num2]) do 
    String.to_integer(num1) + String.to_integer(num2)
  end
  defp _calculate([num1, "-", num2]) do 
    String.to_integer(num1) - String.to_integer(num2)
  end
  defp _calculate([num1, "*", num2]) do 
    String.to_integer(num1) * String.to_integer(num2)
  end
  defp _calculate([num1, "/", num2]) do 
    String.to_integer(num1) / String.to_integer(num2)
  end

  #StringsAndBinaries-5
  def f(x, l) do
    String.ljust(x, div(l,2) - div(String.length(x),2) + String.length(x))
  end
  def center(list) do
    longest = list 
              |> Enum.map(&String.length/1) 
              |> Enum.max()

    list 
    |> Enum.map(&f(&1,longest)) 
    |> Enum.map(&String.rjust(&1, longest))
    |> Enum.map(&IO.puts(&1))
  end

  #StringsAndBinaries-6
  def capitalize_sentences(str) do
    str 
    |> String.split(". ") 
    |> Enum.map(&String.capitalize/1)
    |> Enum.join(". ")
  end

  #StringsAndBinaries-7
  defp _f([id, ship_to, net_amount]) do
    [String.to_integer(id), String.to_atom(String.lstrip(ship_to, ?:)), String.to_float(net_amount)]
  end
  def f(tax_rates) do
    {:ok, file} = File.open("test/orders.csv")
    
    keywords = IO.read(file, :line) 
               |> String.strip
               |> String.split(",")    
               |> Enum.map(&String.to_atom(&1)) 

    value = IO.stream(file, :line) 
            |> Enum.to_list 
            |> Enum.map(fn x -> x 
                                |> String.strip 
                                |> String.split(",") 
                                |> _f()
                        end)
    File.close(file)

    orders = Enum.map value, &Enum.zip(keywords, &1)

    Ch7.calc_total_amount(tax_rates, orders)
  end

end

