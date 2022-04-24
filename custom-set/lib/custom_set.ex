defmodule CustomSet do
  defstruct map: []
  @opaque t :: %__MODULE__{map: map}

  @spec new(Enum.t()) :: t
  def new(enumerable), do: %__MODULE__{map: Enum.uniq(enumerable) |> Enum.into([])}

  @spec empty?(t) :: boolean
  def empty?(%{map: []}), do: true
  def empty?(_), do: false

  @spec contains?(t, any) :: boolean
  def contains?(%{map: map}, element), do: Enum.member?(map, element)

  @spec subset?(t, t) :: boolean
  def subset?(%{map: map_a}, %{map: map_b}), do: Enum.all?(map_a, &Enum.member?(map_b, &1))

  @spec disjoint?(t, t) :: boolean
  def disjoint?(%{map: []}, _), do: true
  def disjoint?(_, %{map: []}), do: true

  @spec equal?(t, t) :: boolean
  def equal?(%{map: map_a}, %{map: map_b}), do: map_a == map_b

  @spec add(t, any) :: t
  def add(custom_set, element), do: new([element | custom_set.map])

  @spec intersection(t, t) :: t
  def intersection(set, set), do: set
  def intersection(%__MODULE__{map: []}, _), do: new([])
  def intersection(_, %__MODULE__{map: []}), do: new([])

  def intersection(set_1, set_2) when length(set_1.map) < length(set_2.map),
    do: intersection(set_2, set_1)

  def intersection(set_1, set_2) when length(set_1.map) >= length(set_2.map) do
    Enum.reduce(set_1.map, [], fn ele, acc ->
      if contains?(set_2, ele), do: [ele | acc], else: acc
    end)
    |> new()
  end

  @spec difference(t, t) :: t
  def difference(%{map: []}, _), do: %CustomSet{map: []}
  def difference(%{map: map}, %{map: []}), do: %CustomSet{map: map}

  def difference(%{map: map_1}, %{map: map_2}),
    do: %CustomSet{map: Enum.reject(map_1, &Enum.member?(map_2, &1))}

  @spec union(t, t) :: t
  def union(%{map: []}, %{map: map}), do: %CustomSet{map: map}
  def union(%{map: map}, %{map: []}), do: %CustomSet{map: map}

  def union(%{map: map_1}, %{map: map_2}),
    do: %CustomSet{map: Enum.uniq(map_1 ++ map_2)}
end
