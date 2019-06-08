defmodule Phone do
  @invalid_start_num ~w(0 1)
  @invalid_num "0000000000"

  @doc """
  Remove formatting from a phone number.

  Returns "0000000000" if phone number is not valid
  (10 digits or "1" followed by 10 digits)

  ## Examples

  iex> Phone.number("212-555-0100")
  "2125550100"

  iex> Phone.number("+1 (212) 555-0100")
  "2125550100"

  iex> Phone.number("+1 (212) 055-0100")
  "0000000000"

  iex> Phone.number("(212) 555-0100")
  "2125550100"

  iex> Phone.number("867.5309")
  "0000000000"
  """
  @spec number(String.t()) :: String.t()
  def number(raw) do
    with true <- valid(raw) do
      raw
      |> String.replace(~r/[^\d]/, "")
      |> do_number()
    end
  end

  defp valid(raw) do
    case Regex.scan(~r/[a-zA-Z]/, raw) do
       [] -> true
      _ -> @invalid_num
    end
  end


  defp do_number("1" <> <<a :: binary-size(1)>> <> <<a1 :: binary-size(2)>> <> <<b :: binary-size(1)>> <> <<b1 :: binary-size(6)>> <> "")
    when a not in @invalid_start_num and b not in @invalid_start_num, do: "#{a}#{a1}#{b}#{b1}"

  defp do_number(<<a :: binary-size(1)>> <> <<a1 :: binary-size(2)>> <> <<b :: binary-size(1)>> <> <<b1 :: binary-size(6)>> <> "")
    when a not in @invalid_start_num and b not in @invalid_start_num, do: "#{a}#{a1}#{b}#{b1}"

  defp do_number(_), do: @invalid_num

  @doc """
  Extract the area code from a phone number

  Returns the first three digits from a phone number,
  ignoring long distance indicator

  ## Examples

  iex> Phone.area_code("212-555-0100")
  "212"

  iex> Phone.area_code("+1 (212) 555-0100")
  "212"

  iex> Phone.area_code("+1 (012) 555-0100")
  "000"

  iex> Phone.area_code("867.5309")
  "000"
  """
  @spec area_code(String.t()) :: String.t()
  def area_code(raw) do
    <<area_code :: binary-size(3)>> <> _ = number(raw)
    "#{area_code}"
  end

  @doc """
  Pretty print a phone number

  Wraps the area code in parentheses and separates
  exchange and subscriber number with a dash.

  ## Examples

  iex> Phone.pretty("212-555-0100")
  "(212) 555-0100"

  iex> Phone.pretty("212-155-0100")
  "(000) 000-0000"

  iex> Phone.pretty("+1 (303) 555-1212")
  "(303) 555-1212"

  iex> Phone.pretty("867.5309")
  "(000) 000-0000"
  """
  @spec pretty(String.t()) :: String.t()
  def pretty(raw) do
    <<area_code :: binary-size(3)>> <> <<exchange :: binary-size(3)>> <> <<num :: binary-size(4)>> = number(raw)
    "(#{area_code}) #{exchange}-#{num}"
  end
end
