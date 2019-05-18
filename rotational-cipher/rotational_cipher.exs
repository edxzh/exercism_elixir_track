defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
    |> to_charlist
    |> Enum.map(&transform(&1, shift))
    |> List.to_string
  end

  defp transform(c, shift) when c in ?a..?z, do: rem(c - ?a + shift, 26) + ?a
  defp transform(c, shift) when c in ?A..?Z, do: rem(c - ?A + shift, 26) + ?A
  defp transform(c, _), do: c
end
