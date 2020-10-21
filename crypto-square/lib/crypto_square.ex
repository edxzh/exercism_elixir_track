defmodule CryptoSquare do
  @doc """
  Encode string square methods
  ## Examples

    iex> CryptoSquare.encode("abcd")
    "ac bd"
  """
  @spec encode(String.t()) :: String.t()
  def encode(str) do
    str
    |> String.replace(~r/[[:punct:] ]/, "")
    |> String.length()
    |> get_c_r()
  end

  defp get_c_r(number) do
    squre_root = :math.sqrt(number) |> round()

    {squre_root, squre_root + 1}
  end
end
