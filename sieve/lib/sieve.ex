defmodule Sieve do
  @doc """
  Generates a list of primes up to a given limit.
  """
  @spec primes_to(non_neg_integer) :: [non_neg_integer]
  def primes_to(limit) do
    2..limit
    |> Enum.map(fn e -> {e, false} end)
    |> Map.new
    |> mark_primes(limit)
  end

  def mark_primes(primes_map, limit) do
    number_list = primes_map |> Map.keys()
    primes = get_primes(number_list, limit)
  end

  defp get_primes(number_list, limit) do
  end
end
