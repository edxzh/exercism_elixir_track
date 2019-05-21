defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count(list), do: count(list, 0)
  defp count([head | tail], acc), do: count(tail, acc + 1)
  defp count([], acc), do: acc

  @spec reverse(list) :: list
  def reverse(list), do: reverse(list, [])
  defp reverse([], acc), do: acc
  defp reverse([head | tail], acc), do: reverse(tail, [head | acc])

  @spec map(list, (any -> any)) :: list
  def map(list, f), do: map(list, f, []) |> reverse
  defp map([head | tail], f, acc), do: map(tail, f, [f.(head) | acc])
  defp map([], _, acc), do: acc

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(list, f), do: filter(list, f, []) |> reverse
  defp filter([head | tail], f, acc) do
    if f.(head) do
      filter(tail, f, [head | acc])
    else
      filter(tail, f, acc)
    end
  end
  defp filter([], _, acc), do: acc

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce([head | tail], acc, f), do: reduce(tail, f.(head, acc), f)
  def reduce([], acc, _), do: acc

  @spec append(list, list) :: list
  def append([head | tail], l2), do: [head | append(tail, l2)]
  def append([], l2), do: l2

  @spec concat([[any]]) :: [any]
  def concat([]), do: []
  def concat([head | tail]), do: append(head, concat(tail))
end
