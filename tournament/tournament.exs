defmodule ScoreTableItem do
  defstruct MP: 0, W: 0, D: 0, L: 0, P: 0

  def update(nil, result), do: update(%ScoreTableItem{}, result);
  def update(scores = %{MP: mp, W: w, P: p}, "win"), do: %{scores | MP: mp + 1, W: w + 1, P: p + 3}
  def update(scores = %{MP: mp, L: l}, "loss"), do: %{scores | MP: mp + 1, L: l + 1}
  def update(scores = %{MP: mp, D: d, P: p}, "draw"), do: %{scores | MP: mp + 1, D: d + 1, P: p + 1}
end

defmodule Tournament do
  @output_header "Team                           | MP |  W |  D |  L |  P\n"
  @valid_results ~w(win loss draw)
  @opposite_game_result %{
    "win" => "loss",
    "loss" => "win",
    "draw" => "draw"
  }

  @doc """
  Given `input` lines representing two teams and whether the first of them won,
  lost, or reached a draw, separated by semicolons, calculate the statistics
  for each team's number of games played, won, drawn, lost, and total points
  for the season, and return a nicely-formatted string table.

  A win earns a team 3 points, a draw earns 1 point, and a loss earns nothing.

  Order the outcome by most total points for the season, and settle ties by
  listing the teams in alphabetical order.
  """
  @spec tally(input :: list(String.t())) :: String.t()
  def tally(input) do
    input
    |> Enum.map(&String.split(&1, ";"))
    |> Enum.reduce(%{}, &update_teams_score/2)
    |> print()
  end

  defp update_teams_score([team1, team2, game_result], acc) when game_result in @valid_results do
    acc
    |> Map.put(team1, ScoreTableItem.update(acc[team1], game_result))
    |> Map.put(team2, ScoreTableItem.update(acc[team2], @opposite_game_result[game_result]))
  end
  defp update_teams_score(_, acc), do: acc

  defp print(scores) do
    body = scores
           |> Map.to_list()
           |> Enum.sort(&sort_score/2)
           |> Enum.map(&to_table_item(&1))
           |> Enum.join("\n")

    @output_header <> body
  end

  def sort_score({team1, %{P: p}}, {team2, %{P: p}}), do: team1 <= team2
  def sort_score({_, %{P: p1}}, {_, %{P: p2}}), do: p1 >= p2

  defp to_table_item({team, %ScoreTableItem{MP: mp, W: w, D: d, L: l, P: p}}) do
    "#{String.pad_trailing(team, 31)}|  #{mp} |  #{w} |  #{d} |  #{l} |  #{p}"
  end
end
