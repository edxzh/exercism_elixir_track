defmodule Binary do
  def a ~> b, do: :math.pow(a, b) |> round()

  @doc """
  Convert a string containing a binary number to an integer.

  On errors returns 0.
  """
  @spec to_decimal(String.t()) :: non_neg_integer
  def to_decimal(string) do
    with {:ok, string} <- validate(string) do
      string
      |> String.graphemes()
      |> Enum.map(&String.to_integer/1)
      |> Enum.reverse()
      |> Enum.with_index()
      |> Enum.map(fn {digit, position} -> digit * (2 ~> position) end)
      |> Enum.sum()
    else
      :error -> 0
    end
  end

  defp validate(number_string) do
    if Regex.match?(~r/^[0-1]+$/, number_string), do: {:ok, number_string}, else: :error
  end
end
