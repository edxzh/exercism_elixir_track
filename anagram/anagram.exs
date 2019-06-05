defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    candidates
    |> Enum.filter(&angram_of?(String.downcase(base), String.downcase(&1)))
  end

  defp angram_of?(base, candidate) when base == candidate, do: false
  defp angram_of?(base, candidate) do
    String.graphemes(base) -- String.graphemes(candidate) ==
      String.graphemes(candidate) -- String.graphemes(base)
  end
end
