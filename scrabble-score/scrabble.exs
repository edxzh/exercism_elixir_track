defmodule Scrabble do
  @letter_values %{
    "aeioulnrst" => 1,
    "dg" => 2,
    "bcmp" => 3,
    "fhvwy" => 4,
    "k" => 5,
    "jx" => 8,
    "qz" => 10
  }
  @doc """
  Calculate the scrabble score for the word.
  """
  @spec score(String.t()) :: non_neg_integer
  def score(word) do
    word
    |> String.trim()
    |> String.downcase()
    |> String.graphemes()
    |> Enum.reduce(0, &(&2 + letter_value(&1)))
  end

  defp letter_value(letter) do
    @letter_values
    |> Enum.find(fn {k, v} -> String.contains?(k, letter) end)
    |> Tuple.to_list()
    |> Enum.at(-1)
  end
end
