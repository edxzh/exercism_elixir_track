defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search(numbers, key) do
    do_search(numbers, key, 0, tuple_size(numbers)-1)
  end

  defp do_search({}, _, _, _) do :not_found end
  defp do_search(numbers, key, l, r) do
    half_point = div(l + r, 2)
    middle = elem(numbers, half_point)

    cond do
      middle == key -> {:ok, half_point}
      l >= r -> :not_found
      middle > key -> do_search(numbers, key, l, half_point)
      middle < key -> do_search(numbers, key, (half_point+1), r)
    end
  end
end
