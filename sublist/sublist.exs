defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) do
    cond do
      a === b -> :equal
      length(a) < length(b) and sublist?(a, b) -> :sublist
      length(a) > length(b) and sublist?(b, a) -> :superlist
      true -> :unequal
    end
  end

  def sublist?([], _), do: true
  def sublist?(a, b) do
    Stream.chunk_every(b, length(a), 1) |> Enum.member?(a)
  end
end
