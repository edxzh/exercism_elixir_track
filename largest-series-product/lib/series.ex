defmodule Series do
  @doc """
  Finds the largest product of a given number of consecutive numbers in a given string of numbers.
  """
  @spec largest_product(String.t(), non_neg_integer) :: non_neg_integer
  def largest_product("", size) when size < 0 do
    raise(ArgumentError)
  end

  def largest_product(_number_string, 0) do
    1
  end

  def largest_product(number_string, size) when byte_size(number_string) > 0 and size < 0 do
    raise(ArgumentError)
  end

  def largest_product(number_string, size) when size > byte_size(number_string) do
    raise(ArgumentError)
  end

  def largest_product(number_string, size) do
    String.graphemes(number_string)
    |> Enum.map(&String.to_integer(&1))
    |> Enum.chunk_every(size, 1, :discard)
    |> Enum.map(&Enum.reduce(&1, fn acc, x -> acc * x end))
    |> Enum.max()
  end
end
