defmodule Queens do
  @chessboard_rows 8
  @chessboard_positions 64
  @white_queen_letter "W"
  @black_queen_letter "B"

  @type t :: %Queens{black: {integer, integer}, white: {integer, integer}}
  defstruct black: {}, white: {}

  @doc """
  Creates a new set of Queens
  """
  @spec new() :: Queens.t()
  @spec new({integer, integer}, {integer, integer}) :: Queens.t()
  def new(queen, queen), do: raise ArgumentError

  def new(white \\ {0, 3}, black \\ {7, 3}) do
    %Queens{white: white, black: black}
  end

  @doc """
  Gives a string representation of the board with
  white and black queen locations shown
  """
  @spec to_string(Queens.t()) :: String.t()
  def to_string(%Queens{white: {wx, wy}, black: {bx, by}}) do
    white_queen_position = wx * @chessboard_rows + wy + 1
    black_queen_position = bx * @chessboard_rows + by + 1

    1..@chessboard_positions
    |> Enum.map(&generate_chessboard_points(white_queen_position, black_queen_position, &1))
    |> Enum.chunk_every(@chessboard_rows)
    |> Enum.map(&Enum.join(&1, " "))
    |> Enum.join("\n")
  end

  defp generate_chessboard_points(white_queen_position, _black_queen_position, white_queen_position), do: @white_queen_letter
  defp generate_chessboard_points(_white_queen_position, black_queen_position, black_queen_position), do: @black_queen_letter
  defp generate_chessboard_points(_, _, _), do: "_"

  @doc """
  Checks if the queens can attack each other
  """
  @spec can_attack?(Queens.t()) :: boolean
  def can_attack?(%Queens{white: {wx, wy}, black: {bx, by}}) do
    wx == bx or wy == by or (abs(wx - bx) == abs(wy - by))
  end
end
