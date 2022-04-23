defmodule Change do
  @doc """
    Determine the least number of coins to be given to the user such
    that the sum of the coins' value would equal the correct amount of change.
    It returns {:error, "cannot change"} if it is not possible to compute the
    right amount of coins. Otherwise returns the tuple {:ok, list_of_coins}

    ## Examples

      iex> Change.generate([5, 10, 15], 3)
      {:error, "cannot change"}

      iex> Change.generate([1, 5, 10], 18)
      {:ok, [1, 1, 1, 5, 10]}

  """

  @spec generate(list, integer) :: {:ok, list} | {:error, String.t()}
  def generate(_coins, target) when target < 0, do: {:error, "cannot change"}
  def generate(_coins, 0), do: {:ok, []}

  def generate(coins, target) do
    changes =
      1..target
      |> Enum.reduce(%{0 => []}, &changes_for(&1, &2, coins))

    get_changes(changes, target)
  end

  defp changes_for(target, acc, coins) do
    changes =
      coins
      |> Enum.filter(&acc[target - &1])
      |> Enum.map(&[&1 | acc[target - &1]])
      |> Enum.min_by(&length/1, fn -> nil end)

    (changes && Map.put(acc, target, changes)) || acc
  end

  defp get_changes(changes, target) when is_map_key(changes, target), do: {:ok, changes[target]}
  defp get_changes(_changes, _target), do: {:error, "cannot change"}
end
