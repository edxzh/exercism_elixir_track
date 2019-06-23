defmodule Frequency do
  @doc """
  Count letter frequency in parallel.

  Returns a map of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """
  @spec frequency([String.t()], pos_integer) :: map
  def frequency(texts, workers) do
    stream = Task.async_stream(texts, &count_letters/1, max_concurrency: workers)
    stream
      |> Enum.map(fn {:ok, word_count} -> word_count end)
      |> Enum.reduce(%{}, fn word_count, acc ->
        Map.merge(acc, word_count, fn _k, v1, v2 -> v1 + v2 end)
      end)
  end

  @spec count_letters(String.t()) :: map
  defp count_letters(text) do
    text
      |> String.replace(~r/[^[:alpha:]]/u, "")
      |> String.downcase()
      |> String.graphemes()
      |> Enum.reduce(%{}, fn letter, counts -> Map.update(counts, letter, 1, &(&1 + 1)) end)
  end
end
