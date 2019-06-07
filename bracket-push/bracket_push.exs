defmodule BracketPush do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t()) :: boolean
  def check_brackets(str) do
    str
    |> process([])
    |> check_acc()
  end

  defp process("", acc), do: acc

  defp process(<<x :: binary-size(1)>> <> rest, acc) when x in ["{", "[", "("] do
    process(rest, [x | acc])
  end

  defp process(<<x :: binary-size(1)>> <> rest, acc) when x in ["}", "]", ")"] do
    process(rest, remove_matched(acc, x))
  end

  defp process(<<x :: binary-size(1)>> <> rest, acc) do
    process(rest, acc)
  end

  defp remove_matched(["{" | tail], "}"), do: tail
  defp remove_matched(acc, "}"), do: ["}" | acc]
  defp remove_matched(["[" | tail], "]"), do: tail
  defp remove_matched(acc, "]"), do: ["]" | acc]
  defp remove_matched(["(" | tail], ")"), do: tail
  defp remove_matched(acc, ")"), do: [")" | acc]

  defp check_acc([]), do: true
  defp check_acc(_), do: false
end
