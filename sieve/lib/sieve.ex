defmodule Sieve do
  @doc """
  Generates a list of primes up to a given limit.
  """
  @spec primes_to(non_neg_integer) :: [non_neg_integer]
  def primes_to(1), do: []
  def primes_to(limit) when is_integer(limit) and limit > 1 do
    limit
    |> generate_primes_map
    |> mark_map(limit)
    |> primes_map_to_primes_list
  end

  defp generate_primes_map(limit) do
    2..limit
    |> Enum.map(fn number -> {number, true} end)
    |> Map.new
  end

  defp mark_map(primes_map, limit) do
    2..(:math.sqrt(limit) |> floor)
    |> Enum.reduce(primes_map, &(update_on_prime(&2, &1, limit)) )
  end

  defp update_on_prime(primes_map, num, limit) do
    case primes_map[num] do
      true  -> mark_multiples(num, limit, primes_map)
      false -> primes_map
    end
  end

  defp mark_multiples(check_num, limit, primes_map) do
    check_num..div(limit, check_num)
    |> Enum.map(&(&1 * check_num))
    |> Enum.reduce(primes_map, &(Map.put(&2, &1, false)))
  end

  defp primes_map_to_primes_list(primes_map) do
    primes_map
    |> filter_primes()
    |> Map.keys()
    |> Enum.sort()
  end

  defp filter_primes(primes_map) do
    :maps.filter fn _, v -> v == true end, primes_map
  end
end

