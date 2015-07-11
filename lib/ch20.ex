defmodule My do
  #MacrosAndCodeEvaluation-1
  defmacro unless(condition, clauses) do
    do_clause = Keyword.get(clauses, :do, nil)
    else_clause = Keyword.get(clauses, :else, nil)
    quote do 
      if !unquote(condition) do
        unquote(do_clause)
      else
        unquote(else_clause)
      end
    end
  end
end

defmodule Times do
  #MacrosAndCodeEvaluation-2
  defmacro times_n(times) do
    quote do
      def unquote(:"times_#{times}")(n) do
        unquote(times) * n
      end
    end
  end
end

defmodule Test do
  require My
  require Times
  
  My.unless 1==2 do
    IO.puts "1 != 2"
  else
    IO.puts "1 == 2"
  end

  Times.times_n(3)
  Times.times_n(4)
end

IO.puts Test.times_3(4)
IO.puts Test.times_4(5)
