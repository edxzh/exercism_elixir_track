defmodule Meetup do
  @day_ranges %{
    last: 31..21,
    fourth: 28..22,
    teenth: 19..13,
    third: 21..15,
    second: 14..8,
    first: 7..1
  }

  @weekdays %{
    monday: 1,
    tuesday: 2,
    wednesday: 3,
    thursday: 4,
    friday: 5,
    saturday: 6,
    sunday: 7
  }

  @moduledoc """
  Calculate meetup dates.
  """

  @type weekday ::
          :monday
          | :tuesday
          | :wednesday
          | :thursday
          | :friday
          | :saturday
          | :sunday

  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: :calendar.date()
  def meetup(year, month, weekday, schedule) do
    day = Enum.find(@day_ranges[schedule], &day_at?(year, month, &1, weekday))

    {year, month, day}
  end

  defp day_at?(year, month, day, weekday) do
    Calendar.ISO.valid_date?(year, month, day) &&
      Calendar.ISO.day_of_week(year, month, day) == @weekdays[weekday]
  end
end
