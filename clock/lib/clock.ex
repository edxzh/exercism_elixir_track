defmodule Clock do
  defstruct hour: 0, minute: 0
  @total_hours 24
  @total_mins 60

  @doc """
  Returns a clock that can be represented as a string:

      iex> Clock.new(8, 9) |> to_string
      "08:09"
  """
  @spec new(integer, integer) :: Clock
  def new(h, m) when h >= @total_hours do
    h
    |> rem(@total_hours)
    |> new(m)
  end

  def new(h, m) when h < 0 do
    h
    |> abs()
    |> rem(@total_hours)
    |> Kernel.-(@total_hours)
    |> abs()
    |> new(m)
  end

  def new(h, m) when m >= @total_mins do
    added_hours = div(m, @total_mins)
    new(h + added_hours, rem(m, @total_mins))
  end

  def new(h, m) when m < 0 do
    minus_hours = div(abs(m), @total_mins) + 1
    mins = m
           |> abs()
           |> rem(@total_mins)
           |> Kernel.-(@total_mins)
           |> abs()

    new(h - minus_hours, mins)
  end

  def new(h, m), do: %Clock{hour: h, minute: m}

  @doc """
  Adds two clock times:

      iex> Clock.new(10, 0) |> Clock.add(3) |> to_string
      "10:03"
  """
  @spec add(Clock, integer) :: Clock
  def add(%Clock{hour: h, minute: m}, add_minute),
    do: new(h, m + add_minute)
end

defimpl String.Chars, for: Clock do
  def to_string(%Clock{hour: hour, minute: minute}),
    do: pad(hour) <> ":" <> pad(minute)

  defp pad(n), do: "00#{n}" |> String.slice(-2..-1)
end
