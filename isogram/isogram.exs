defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t()) :: boolean
  def isogram?(sentence) do
    char_list = sentence
                |> String.replace(~r/[\s|-]+/, "")
                |> String.downcase()
                |> String.graphemes()

    char_list == Enum.uniq(char_list)
  end
end
