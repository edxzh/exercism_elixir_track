defmodule Triangle do
  @type kind :: :equilateral | :isosceles | :scalene

  @doc """
  Return the kind of triangle of a triangle with 'a', 'b' and 'c' as lengths.
  """
  @spec kind(number, number, number) :: {:ok, kind} | {:error, String.t()}
  def kind(a, b, c) do
    [a, b, c]
    |> Enum.sort()
    |> do_kind()
  end

  defp do_kind([a, _b, _c]) when a <= 0, do: { :error, "all side lengths must be positive" }
  defp do_kind([a, b, c]) when a + b <= c, do: { :error, "side lengths violate triangle inequality" }
  defp do_kind([a, _a, a]), do: {:ok, :equilateral}
  defp do_kind([a, a, _b]), do: {:ok, :isosceles}
  defp do_kind([a, b, b]), do: {:ok, :isosceles}
  defp do_kind([_, _, _]), do: {:ok, :scalene}
end
