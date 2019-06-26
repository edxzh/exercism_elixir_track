defmodule Luhn do
  @doc """
  Checks if the given number is valid via the luhn formula
  """
  @spec valid?(String.t()) :: boolean
  def valid?(<<number>>) when number in ?0..?9, do: false

  def valid?(number) do
    with {:ok, number} <- validate(number) do
      number
      |> String.graphemes()
      |> Enum.reject(& &1 == " ")
      |> Enum.reverse()
      |> Enum.map(&String.to_integer/1)
      |> Enum.with_index()
      |> Enum.map(fn {digit, index} -> double_every_second(digit, index) end)
      |> Enum.sum()
      |> rem(10)
      |> Kernel.==(0)
    end
  end

  defp validate(number) do
    if Regex.match?(~r/^[\d\s]+$/, number) and String.trim(number) !== "0", do: {:ok, number}, else: false
  end

  defp double_every_second(digit, index) when rem(index, 2) == 0, do: digit
  defp double_every_second(9, _index), do: 9
  defp double_every_second(digit, _index), do: rem(digit * 2, 9)
end
