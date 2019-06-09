defmodule AllYourBase do
  def a ~> b, do: :math.pow(a, b) |> round()

  @doc """
  Given a number in base a, represented as a sequence of digits, converts it to base b,
  or returns nil if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: list
  def convert(digits, base_a, base_b) do
    with {:ok, list} <- validate(digits, base_a, base_b) do
      list
      |> Enum.reverse()
      |> Enum.with_index()
      |> Enum.map(&multiply_with_base(&1, base_a))
      |> Enum.sum()
      |> to_digits(base_b)
    else
      :error -> nil
    end
  end

  defp validate([], _base_a, _base_b), do: :error
  defp validate(_list, base_a, base_b) when base_a < 2 or base_b < 2, do: :error

  defp validate(list, base_a, _base_b) do
    case Enum.any?(list, &(&1 < 0 or &1 >= base_a)) do
       true -> :error
      _ -> {:ok, list}
    end
  end

  defp multiply_with_base({digit, pos}, base), do: digit * (base ~> pos)

  defp to_digits(0, _), do: [0]
  defp to_digits(number, base), do: do_to_digits(number, base, [])

  defp do_to_digits(0, _, acc), do: acc
  defp do_to_digits(number, base, acc) do
    do_to_digits(div(number, base), base, [rem(number, base) | acc])
  end
end
