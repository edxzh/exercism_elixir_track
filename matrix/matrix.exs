defmodule Matrix do
  defstruct rows: [], columns: []

  @doc """
  Convert an `input` string, with rows separated by newlines and values
  separated by single spaces, into a `Matrix` struct.
  """
  @spec from_string(input :: String.t()) :: %Matrix{}
  def from_string(input) do
    rows = input
           |> String.split("\n")
           |> Enum.map(&String.split(&1, " "))
           |> Enum.map(fn row -> row |> Enum.map(&String.to_integer/1) end)
    columns = rows
              |> Enum.zip()
              |> Enum.map(&Tuple.to_list/1)

    %Matrix{rows: rows, columns: columns}
  end

  @doc """
  Write the `matrix` out as a string, with rows separated by newlines and
  values separated by single spaces.
  """
  @spec to_string(matrix :: %Matrix{}) :: String.t()
  def to_string(matrix) do
    matrix.rows
    |> Enum.map_join("\n", &Enum.join(&1, " "))
  end

  @doc """
  Given a `matrix`, return its rows as a list of lists of integers.
  """
  @spec rows(matrix :: %Matrix{}) :: list(list(integer))
  def rows(matrix), do: matrix.rows

  @doc """
  Given a `matrix` and `index`, return the row at `index`.
  """
  @spec row(matrix :: %Matrix{}, index :: integer) :: list(integer)
  def row(matrix, index), do: matrix.rows |> Enum.at(index)

  @doc """
  Given a `matrix`, return its columns as a list of lists of integers.
  """
  @spec columns(matrix :: %Matrix{}) :: list(list(integer))
  def columns(matrix), do: matrix.columns

  @doc """
  Given a `matrix` and `index`, return the column at `index`.
  """
  @spec column(matrix :: %Matrix{}, index :: integer) :: list(integer)
  def column(matrix, index), do: matrix.columns |> Enum.at(index)
end
