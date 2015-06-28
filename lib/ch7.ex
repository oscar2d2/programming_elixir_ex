defmodule Ch7 do
  def map([], _) do
    []
  end

  def map([head | tail], func) do
    [func.(head) | map(tail, func)]
  end

  def reduce([], value, _) do
    value
  end

  def reduce([head | tail], value, func) do
    reduce(tail, func.(head, value), func)
  end

  #ListsAndRecursion-0
  def sum_no_acc([]), do: 0

  def sum_no_acc([head | tail]), do: head + sum_no_acc(tail)

  #ListsAndRecursion-1
  def mapsum(list, func) do
    list |> map(func) |> reduce(0,&(&1+&2))
  end

  #ListsAndRecursion-2
  def max([head | tail]), do: reduce(tail, head, &_max/2)

  def _max(x,y) when x >= y, do: x
  def _max(x,y) when x < y, do: y

  #ListsAndRecursion-3
  def caesar(list, n), do: map(list, &(rem(&1+n-97,26)+97))

  #ListsAndRecursion-4
  def span(from, to) when from > to do
    []
  end

  def span(from, to) do
    [from | span(from+1, to)]
  end

  #ListsAndRecursion-5
  def all?([], _), do: true
  def all?([head | tail], func) do
    if func.(head) do
      all?(tail, func)
    else
      false
    end
  end

  def each([], _), do: :ok
  def each([head | tail], func) do
    func.(head)
    each(tail, func)
  end

  def filter([], _), do: []
  def filter([head | tail], func) do
    if func.(head) do
      [head | filter(tail, func)]
    else
      filter(tail, func)
    end
  end

  def split(list, n) when n >= 0, do: _split(list, [], n)
  def split(list, n) when n < 0 do 
  split(Enum.reverse(list), -n)
  |> Enum.map (Enum.reverse)
  end 
  defp _split([], acc, _), do: {Enum.reverse(acc), []}
  defp _split(list, acc, 0), do: {Enum.reverse(acc), list}
  defp _split([head | tail], acc, n), do: _split(tail, [head | acc], n-1)

  def take([], _), do: []
  def take(_, 0), do: []
  def take([head | tail], n) when n > 0 do
    [head | take(tail, n-1)]
  end
  def take(list, n) when n < 0, do: list |> Enum.reverse |> take(-n) |> Enum.reverse

  #ListsAndRecursion-6
  def flatten(list), do: _flatten(list, []) |> Enum.reverse
  defp _flatten([], acc), do: acc
  defp _flatten([head | tail], acc) when is_list(head) do
    _flatten(tail, _flatten(head, acc))
  end
  defp _flatten([head | tail], acc) do
    _flatten(tail, [head | acc])
  end

  #ListsAndRecursion-7
  def primes(n) do
    for i <- span(3, n), all?(span(2,i-1), &(rem(i,&1) != 0)), into: [2], do: i
  end

  #ListsAndRecursion-8
  def calc_total_amount(tax_rates, orders) do
    for order <- orders do
      if order[:ship_to] in Keyword.keys tax_rates do
        put_in(order[:total_amount], order[:net_amount] * (tax_rates[order[:ship_to]] + 1))
      else
        put_in(order[:total_amount], order[:net_amount])
      end
    end 
  end
end

#tax_rates = [ NC: 0.075, TX: 0.08 ]
#orders = [
#  [ id: 123, ship_to: :NC, net_amount: 100.00 ],
#  [ id: 124, ship_to: :OK, net_amount:  35.50 ],
#  [ id: 125, ship_to: :TX, net_amount:  24.00 ],
#  [ id: 126, ship_to: :TX, net_amount:  44.80 ],
#  [ id: 127, ship_to: :NC, net_amount:  25.00 ],
#  [ id: 128, ship_to: :MA, net_amount:  10.00 ],
#  [ id: 129, ship_to: :CA, net_amount: 102.00 ],
#  [ id: 120, ship_to: :NC, net_amount:  50.00 ]
#]
#
#MyList.calc_total_amount(tax_rates, orders)
