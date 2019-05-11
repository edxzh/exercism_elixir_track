defmodule Bob do
  def hey(input) do
    cond do
      is_silence?(input) -> "Fine. Be that way!"
      is_shouting_question?(input) -> "Calm down, I know what I'm doing!"
      is_shouting?(input) -> "Whoa, chill out!"
      is_question?(input) -> "Sure."
      true -> "Whatever."
    end
  end

  defp is_shouting?(string), do: is_upcase?(string) && has_letters?(string)
  defp is_question?(string), do: String.ends_with?(string, "?")
  defp is_shouting_question?(string), do: is_shouting?(string) && is_question?(string)
  defp is_silence?(string), do: String.trim(string) == ""
  defp is_upcase?(string), do: string == String.upcase(string)
  defp has_letters?(string), do: String.upcase(string) != String.downcase(string)
end
