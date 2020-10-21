defmodule CryptoSquare do
  @doc """
  Encode string square methods
  ## Examples

    iex> CryptoSquare.encode("abcd")
    "ac bd"
  """
  @spec encode(String.t()) :: String.t()
  def encode(""), do: ""

  def encode(str) do
    normalized_str = normalize(str)

    c = normalized_str
        |> String.length()
        |> get_c()

    do_encode(normalized_str, c)
  end

  defp do_encode(str, c) do
    str
    |> String.graphemes()
    |> Enum.chunk_every(c, c, Stream.cycle([""]))
    |> Enum.zip()
    |> Enum.map_join(" ", &Tuple.to_list/1)
  end

  defp normalize(str) do
    str
    |> String.downcase()
    |> String.replace(~r/[[:punct:] ]/, "")
  end

  defp get_c(number) do
    squre_root = :math.sqrt(number) |> ceil()
  end
end
