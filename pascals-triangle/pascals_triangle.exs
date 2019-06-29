defmodule PascalsTriangle do
  @doc """
  Calculates the rows of a pascal triangle
  with the given height
  """
  @spec rows(integer) :: [[integer]]
  def rows(num) do
    do_rows(num, 1, [[1]])
  end

  defp do_rows(num, count, triangle) when count >= num do
    triangle |> Enum.reverse()
  end

  defp do_rows(num, count, triangle = [h | _t]) do
    do_rows(num, count + 1, [row_after(h) | triangle])
  end

  @spec row_after([integer]) :: [integer]
  defp row_after(prev_row) do
    row_after(prev_row, 0, [])
  end

  defp row_after([], _, res), do: [1 | res]

  defp row_after([h | t], last, acc) do
    row_after(t, h, [last + h | acc])
  end
end

