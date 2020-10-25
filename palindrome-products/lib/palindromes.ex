defmodule Palindromes do
  @doc """
  Generates all palindrome products from an optionally given min factor (or 1) to a given max factor.
  """
  @spec generate(non_neg_integer, non_neg_integer) :: map
  def generate(max_factor, min_factor \\ 1) do
    (for x<-min_factor..max_factor, y<-x..max_factor, is_palindrome?(x*y) ,do: [x, y])
    |> Enum.group_by(fn([a,b]) -> a*b end)
  end

  defp is_palindrome?(number) when is_integer(number), do: is_palindrome?(Integer.to_charlist(number,10))
  defp is_palindrome?(number) when is_list(number), do: number == Enum.reverse(number)
end
