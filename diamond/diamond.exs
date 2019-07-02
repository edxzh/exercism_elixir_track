defmodule Diamond do
  @doc """
  Given a letter, it prints a diamond starting with 'A',
  with the supplied letter at the widest point.
  """
  @spec build_shape(char) :: String.t()
  def build_shape(letter) do
    (letter - ?A)
    |> generate_strings()
    |> mirror_horizontal()
    |> mirror_vertical()
    |> Enum.reduce("", fn x, acc -> acc <> x <> "\n" end)
  end

  def generate_strings(l) do
    for n <- 0..l,
        do: String.duplicate(" ", l - n) <> List.to_string([?A + n]) <> String.duplicate(" ", n)
  end

  def mirror_horizontal(string) do
    mirror_string = &(String.reverse(&1) |> String.slice(1..-1))
    Enum.map(string, fn x -> x <> mirror_string.(x) end)
  end

  def mirror_vertical(strings) do
    strings ++ tl(Enum.reverse(strings))
  end
end
