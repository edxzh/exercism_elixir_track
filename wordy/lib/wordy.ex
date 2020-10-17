defmodule Wordy do
  @doc """
  Calculate the math problem in the sentence.
  """
  @spec answer(String.t()) :: integer
  def answer("What is " <> question) do
    {n, rest} = Integer.parse(question)

    answer(rest, n)
  end

  def answer(_), do: raise(ArgumentError)

  defp answer("?", acc), do: acc

  defp answer(" plus " <> question, acc) do
    {n, rest} = Integer.parse(question)

    answer(rest, acc + n)
  end

  defp answer(" minus " <> question, acc) do
    {n, rest} = Integer.parse(question)

    answer(rest, acc - n)
  end

  defp answer(" multiplied by " <> question, acc) do
    {n, rest} = Integer.parse(question)

    answer(rest, acc * n)
  end

  defp answer(" divided by " <> question, acc) do
    {n, rest} = Integer.parse(question)

    answer(rest, acc / n)
  end

  defp answer(_, _), do: raise(ArgumentError)
end
