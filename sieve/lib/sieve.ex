defmodule Sieve do
  @doc """
  Generates a list of primes up to a given limit.
  """
  @spec primes_to(non_neg_integer) :: [non_neg_integer]
  def primes_to(limit) do
    2..limit
    |> Enum.map(fn e -> {e, true} end)
    |> Map.new
    |> mark_primes(limit)
  end

  def mark_primes(number_map, limit) do
    square_root = :math.sqrt(limit) |> ceil()

    2..square_root
    |> Enum.each(fn p ->
      if (Map.get(number_map, p) == true) do
        update_number_map(number_map, p, limit)
      end
    end)
  end

  def update_number_map(number_map, p, limit) do
  end
end
