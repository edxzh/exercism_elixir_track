defmodule ScaleGenerator do
  @chromatic_scale ~w(A A# B C C# D D# E F F# G G# A)
  @flat_chromatic_scale ~w(A Bb B C Db D Eb E F Gb G Ab A)
  @total_notes 12

  @doc """
  Find the note for a given interval (`step`) in a `scale` after the `tonic`.

  "m": one semitone
  "M": two semitones (full tone)
  "A": augmented second (three semitones)

  Given the `tonic` "D" in the `scale` (C C# D D# E F F# G G# A A# B C), you
  should return the following notes for the given `step`:

  "m": D#
  "M": E
  "A": F
  """
  @spec step(scale :: list(String.t()), tonic :: String.t(), step :: String.t()) ::
          list(String.t())
  def step(scale, tonic, step) do
    tonic_index = scale
                  |> Enum.find_index(& &1 == tonic)
                  |> Kernel.+(step_inc(step))
                  |> rem(@total_notes)

    Enum.at(scale, tonic_index)
  end

  defp step_inc("m"), do: 1
  defp step_inc("M"), do: 2
  defp step_inc("A"), do: 3
  defp step_inc(step), do: step

  @doc """
  The chromatic scale is a musical scale with thirteen pitches, each a semitone
  (half-tone) above or below another.

  Notes with a sharp (#) are a semitone higher than the note below them, where
  the next letter note is a full tone except in the case of B and E, which have
  no sharps.

  Generate these notes, starting with the given `tonic` and wrapping back
  around to the note before it, ending with the tonic an octave higher than the
  original. If the `tonic` is lowercase, capitalize it.

  "C" should generate: ~w(C C# D D# E F F# G G# A A# B C)
  """
  @spec chromatic_scale(tonic :: String.t()) :: list(String.t())
  def chromatic_scale(tonic \\ "C") do
    Enum.map(0..@total_notes, &step(@chromatic_scale, String.capitalize(tonic), &1))
  end

  @doc """
  Sharp notes can also be considered the flat (b) note of the tone above them,
  so the notes can also be represented as:

  A Bb B C Db D Eb E F Gb G Ab

  Generate these notes, starting with the given `tonic` and wrapping back
  around to the note before it, ending with the tonic an octave higher than the
  original. If the `tonic` is lowercase, capitalize it.

  "C" should generate: ~w(C Db D Eb E F Gb G Ab A Bb B C)
  """
  @spec flat_chromatic_scale(tonic :: String.t()) :: list(String.t())
  def flat_chromatic_scale(tonic \\ "C") do
    Enum.map(0..@total_notes, &step(@flat_chromatic_scale, tonic, &1))
  end

  @doc """
  Certain scales will require the use of the flat version, depending on the
  `tonic` (key) that begins them, which is C in the above examples.

  For any of the following tonics, use the flat chromatic scale:

  F Bb Eb Ab Db Gb d g c f bb eb

  For all others, use the regular chromatic scale.
  """
  @spec find_chromatic_scale(tonic :: String.t()) :: list(String.t())
  def find_chromatic_scale("F"), do: flat_chromatic_scale("F")

  def find_chromatic_scale(<<major :: binary-size(1)>> <> "b") do
    String.upcase(major) <> "b"
    |> flat_chromatic_scale()
  end

  def find_chromatic_scale(<<tonic>>) when tonic in ?c..?g do
    <<tonic>>
    |> String.upcase()
    |> flat_chromatic_scale()
  end
  def find_chromatic_scale(tonic), do: chromatic_scale(tonic)

  @doc """
  The `pattern` string will let you know how many steps to make for the next
  note in the scale.

  For example, a C Major scale will receive the pattern "MMmMMMm", which
  indicates you will start with C, make a full step over C# to D, another over
  D# to E, then a semitone, stepping from E to F (again, E has no sharp). You
  can follow the rest of the pattern to get:

  C D E F G A B C
  """
  @spec scale(tonic :: String.t(), pattern :: String.t()) :: list(String.t())
  def scale(tonic, pattern) do
    tonic_up = String.capitalize(tonic)
    chromatic = find_chromatic_scale(tonic)

    scale(chromatic, pattern, [tonic_up])
  end

  def scale(chromatic, <<step :: binary-size(1)>> <> rest, acc) do
    tonic = List.last(acc)
    note = step(chromatic, tonic, step)

    scale(chromatic, rest, acc ++ [note])
  end

  def scale(_, _, acc), do: acc
end
