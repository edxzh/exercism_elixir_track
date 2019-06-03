defmodule Pangram do
  @doc """
  Determines if a word or sentence is a pangram.
  A pangram is a sentence using every letter of the alphabet at least once.

  Returns a boolean.

    ## Examples

      iex> Pangram.pangram?("the quick brown fox jumps over the lazy dog")
      true

  """

  @spec pangram?(String.t()) :: boolean
  def pangram?(sentence) do
    letter_length(sentence) == 26
  end

  defp letter_length(sentence) do
    Regex.scan(~r/[a-z]/, String.downcase(sentence))
    |> Enum.flat_map(& &1)
    |> Enum.uniq
    |> length
  end
end
