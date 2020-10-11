defmodule PerfectNumbers do
  @doc """
  Determine the aliquot sum of the given `number`, by summing all the factors
  of `number`, aside from `number` itself.

  Based on this sum, classify the number as:

  :perfect if the aliquot sum is equal to `number`
  :abundant if the aliquot sum is greater than `number`
  :deficient if the aliquot sum is less than `number`
  """
  @spec classify(number :: integer) :: {:ok, atom} | {:error, String.t()}
  def classify(number) when number <= 0, do: {:error, "Classification is only possible for natural numbers."}
  def classify(number) when number == 1, do: {:ok, :deficient}
  def classify(number) do
    aliquot_sum = get_aliquot_sum(number, div(number, 2), 1)

    case aliquot_sum - number do
      result when result == 0 ->
        {:ok, :perfect}
      result when result < 0 ->
        {:ok, :deficient}
      result when result > 0 ->
        {:ok, :abundant}
    end
  end

  defp get_aliquot_sum(_number, 1, sum), do: sum
  defp get_aliquot_sum(number, factor, sum) when rem(number, factor) == 0 do
    get_aliquot_sum(number, factor-1, sum + factor)
  end
  defp get_aliquot_sum(number, factor, sum), do: get_aliquot_sum(number, factor-1, sum)
end
