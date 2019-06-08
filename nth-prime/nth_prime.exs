defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(0), do: raise("Number can't be 0")

  def nth(count) do
    Stream.iterate(2, &next_prime/1)
    |> Enum.take(count)
    |> List.last
  end

  defp next_prime(number) do
    if is_prime?(number + 1), do: number + 1, else: next_prime(number + 1)
  end

  defp is_prime?(2), do: true

  defp is_prime?(number) do
    Enum.all?(2..ceil(:math.sqrt(number)), &(rem(number, &1) != 0))
  end
end
