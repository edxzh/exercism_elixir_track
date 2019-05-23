defmodule PigLatin do
  @vowels ["a", "e", "i", "o", "u"]
  @consonants ["b", "c", "d", "f", "g", "h", "j", "k", "l", "m", "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z"]
  @x_y ["x", "y"]
  @specials [ "qu", "ch", "squ", "th", "thr", "sch" ]

  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |>String.split(" ")
    |>Enum.map(&translate_word(&1, ""))
    |>Enum.join(" ")
  end

  defp translate_word(<<x :: binary-size(1)>> <> <<y :: binary-size(1)>> <> rest, acc) when x in @x_y and y in @consonants do
    x <> y <> rest <> acc <> "ay"
  end

  defp translate_word(<<x :: binary-size(1)>> <> rest, acc) when x in @vowels do
    x <> rest <> acc <> "ay"
  end

  defp translate_word(<<x :: binary-size(3)>> <> rest, acc) when x in @specials do
    translate_word(rest, acc <> x)
  end

  defp translate_word(<<x :: binary-size(2)>> <> rest, acc) when x in @specials do
    translate_word(rest, acc <> x)
  end

  defp translate_word(<<x :: binary-size(1)>>  <> rest, acc) do
    translate_word(rest, acc <> x)
  end
end
