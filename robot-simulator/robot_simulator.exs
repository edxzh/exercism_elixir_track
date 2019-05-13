defmodule RobotSimulator do
  @left_direction_map %{
    :east => :north,
    :north => :west,
    :west => :south,
    :south => :east
  }
  @right_direction_map %{
    :east => :south,
    :south => :west,
    :west => :north,
    :north => :east
  }
  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(direction \\ :north, position \\ {0, 0}) do
    with :ok <- validate_direction(direction),
         :ok <- validate_position(position), do: {direction, position}
  end

  defp validate_direction(direction) when direction in [:east, :north, :south, :west], do: :ok
  defp validate_direction(_), do: {:error, "invalid direction"}

  defp validate_position({x, y}) when is_integer(x) and is_integer(y), do: :ok
  defp validate_position(_), do: {:error, "invalid position"}

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions) do
    instructions
    |> String.graphemes
    |> Enum.reduce(robot, &move(&2, &1))
  end

  defp move({:east, {x, y}}, "A"), do: {:east, {x + 1, y}}
  defp move({:west, {x, y}}, "A"), do: {:west, {x - 1, y}}
  defp move({:north, {x, y}}, "A"), do: {:north, {x, y + 1}}
  defp move({:south, {x, y}}, "A"), do: {:south, {x, y - 1}}

  defp move({direction, position}, "L"), do: {@left_direction_map[direction], position}
  defp move({direction, position}, "R"), do: {@right_direction_map[direction], position}

  defp move(_, _), do: {:error, "invalid instruction"}

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction({direction, _}) do
    direction
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position({_, position}) do
    position
  end
end
