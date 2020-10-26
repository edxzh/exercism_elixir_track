defmodule RailFenceCipher do
  @doc """
  Encode a given plaintext to the corresponding rail fence ciphertext
  """
  @spec encode(String.t(), pos_integer) :: String.t()
  def encode(str, 1), do: str

  def encode(str, rails) do
    rails
    |> fence(String.length(str))
    |> Stream.zip(String.graphemes(str))
    |> Enum.sort_by(&elem(&1, 0))
    |> text()
  end

  @doc """
  Decode a given rail fence ciphertext to the corresponding plaintext
  """
  @spec decode(String.t(), pos_integer) :: String.t()
  def decode(str, 1), do: str

  def decode(str, rails) do
    rails
    |> fence(String.length(str))
    |> Enum.sort()
    |> Enum.zip(String.graphemes(str))
    |> Enum.sort(fn {{_, x}, _}, {{_, y}, _} -> x <= y end)
    |> text()
  end

  defp fence(rails, length) do
    zigzag(rails) |> Stream.take(length) |> Stream.zip(0..(length - 1))
  end

  defp zigzag(rails) do
    Stream.concat(zig(rails), zag(rails)) |> Stream.cycle()
  end

  defp zig(rails), do: 0..(rails - 1)

  defp zag(rails), do: (rails - 2)..1

  defp text(fence), do: Enum.map(fence, &elem(&1, 1)) |> Enum.join()
end
