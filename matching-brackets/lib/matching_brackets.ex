defmodule MatchingBrackets do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t()) :: boolean
  def check_brackets(str) do
    str
    |> String.graphemes()
    |> check_brackets([])
  end

  defp check_brackets([], []), do: true
  defp check_brackets(["[" | tail], stack), do: check_brackets(tail, ["[" | stack])
  defp check_brackets(["{" | tail], stack), do: check_brackets(tail, ["{" | stack])
  defp check_brackets(["(" | tail], stack), do: check_brackets(tail, ["(" | stack])
  defp check_brackets(["]" | tail], ["[" | stack]), do: check_brackets(tail, stack)
  defp check_brackets(["}" | tail], ["{" | stack]), do: check_brackets(tail, stack)
  defp check_brackets([")" | tail], ["(" | stack]), do: check_brackets(tail, stack)
  defp check_brackets(["]" | _], _), do: false
  defp check_brackets(["}" | _], _), do: false
  defp check_brackets([")" | _], _), do: false
  defp check_brackets([], _stack), do: false
  defp check_brackets([_ | tail], stack), do: check_brackets(tail, stack)
end
