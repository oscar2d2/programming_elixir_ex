#Protocols-1
defprotocol Caesar do
  def encrypt(string, shift)
  def rot13(string)
end

defimpl Caesar, for: [List, BitString] do
  def encrypt(string, shift) when is_list(string) do
    string 
    |> Enum.map(&(&1+shift)) 
  end

  def encrypt(string, shift) when is_binary(string) do
    string 
    |> String.to_char_list 
    |> encrypt(shift) 
    |> List.to_string
  end

  def rot13(string) do
    encrypt(string, 13) 
  end
end
