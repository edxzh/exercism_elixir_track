defmodule Accumulate do
  @doc """
    Given a list and a function, apply the function to each list item and
    replace it with the function's return value.

    Returns a list.

    ## Examples

      iex> Accumulate.accumulate([], fn(x) -> x * 2 end)
      []

      iex> Accumulate.accumulate([1, 2, 3], fn(x) -> x * 2 end)
      [2, 4, 6]

  """

  @spec accumulate(list, (any -> any)) :: list
  def accumulate(list, fun), do: accumulate(list, fun, [])
  def accumulate([], _, acc), do: acc

  def accumulate([head | rest], fun, acc),
    do: accumulate(rest, fun, [fun.(head) | acc]) |> reverse()

  defp reverse(list), do: reverse(list, [])
  defp reverse([], acc), do: acc
  defp reverse([head | rest], acc), do: reverse(rest, [head | acc])
end
