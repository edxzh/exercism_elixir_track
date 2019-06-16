defmodule Garden do
  @student_names ~w(
    alice bob charlie
    david eve fred
    ginny harriet ileana
    joseph kincaid larry
  )a

  @plant_mapping %{
    "V" => :violets,
    "R" => :radishes,
    "C" => :clover,
    "G" => :grass,
  }

  @doc """
    Accepts a string representing the arrangement of cups on a windowsill and a
    list with names of students in the class. The student names list does not
    have to be in alphabetical order.

    It decodes that string into the various gardens for each student and returns
    that information in a map.
  """

  @spec info(String.t(), list) :: map
  def info(info_string, student_names \\ @student_names) do
    plant_rows = String.split(info_string, "\n")

    student_names
    |> Enum.sort()
    |> Enum.with_index()
    |> Enum.reduce(%{}, &student_plants(&1, plant_rows, &2))
  end

  defp student_plants({student_name, index}, plant_rows, acc) do
    Map.put(acc, student_name, find_plants(index, plant_rows))
  end

  defp find_plants(index, plant_rows) do
    plant_rows
    |> Enum.map(&String.graphemes(&1))
    |> Enum.flat_map(&Enum.slice(&1, index * 2, 2))
    |> Enum.map(&@plant_mapping[&1])
    |> List.to_tuple()
  end
end
