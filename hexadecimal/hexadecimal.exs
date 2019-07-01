defmodule Hexadecimal do
  @base 16

  @doc """
    Accept a string representing a hexadecimal value and returns the
    corresponding decimal value.
    It returns the integer 0 if the hexadecimal is invalid.
    Otherwise returns an integer representing the decimal value.

    ## Examples

      iex> Hexadecimal.to_decimal("invalid")
      0

      iex> Hexadecimal.to_decimal("af")
      175

  """

  @spec to_decimal(binary) :: integer
  def to_decimal(hex) do
    hex
    |> String.downcase
    |> String.to_charlist
    |> Enum.reduce_while(0, fn
      digit, acc when digit in (?0..?9) -> {:cont, acc * @base + digit - ?0}
      digit, acc when digit in (?a..?f) -> {:cont, acc * @base + digit - ?a + 10}
      _, _ -> {:halt, 0}
    end)
  end

end
