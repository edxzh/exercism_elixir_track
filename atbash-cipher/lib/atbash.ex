defmodule Atbash do
  @doc """
  Encode a given plaintext to the corresponding ciphertext

  ## Examples

  iex> Atbash.encode("completely insecure")
  "xlnko vgvob rmhvx fiv"
  """
  @spec encode(String.t()) :: String.t()
  def encode(plaintext) do
    plaintext
    |> shift()
    |> Enum.chunk_every(5)
    |> Enum.map_join(" ", &to_string(&1))
  end

  @spec decode(String.t()) :: String.t()
  def decode(cipher) do
    cipher
    |> shift()
    |> to_string()
  end

  defp shift(string) do
    input
    |> String.downcase()
    |> String.replace(~r/[[:punct:] ]/, "")
    |> to_charlist()
    |> Enum.map(&rotate/1)
  end

  defp rotate(char) when char >= ?0 and char <= ?9, do: char
  defp rotate(char), do: ?a + (?z - char)
end
