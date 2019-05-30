defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(string) do
    string
    |> String.graphemes()
    |> Enum.chunk_by(& &1)
    |> Enum.reduce("", &(&2 <> compress(hd(&1), length(&1))))
  end

  defp compress(char, 1), do: char
  defp compress(char, count), do: Integer.to_string(count) <> char

  @spec decode(String.t()) :: String.t()
  def decode(string) do
    Regex.split(~r/\d*\D/, string, include_captures: true, trim: true)
    |> Enum.reduce("", &(&2 <> decompress(String.last(&1), String.slice(&1, 0..-2))))
  end

  defp decompress(char, ""), do: char
  defp decompress(char, count), do: String.duplicate(char, String.to_integer(count))
end

