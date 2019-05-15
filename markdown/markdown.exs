defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.
## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"
  """
  @spec parse(String.t()) :: String.t()
  def parse(m) do
    m
    |> String.split("\n")
    |> Enum.map_join(&process/1)
    |> process_font_bold
    |> patch
  end

  defp process("#" <> t), do: t |> parse_header
  defp process("* " <> t), do: t |> parse_font
  defp process(t), do: "<p>#{t}</p>"

  defp parse_header("#" <> t, hl \\ 1), do: parse_header(t, hl + 1)
  defp parse_header(" " <> t, hl), do: "<h#{hl}>#{t}</h#{hl}>"

  defp parse_font(t), do: "<li>#{t}</li>"

  defp process_font_bold(t) do
    t
    |> String.replace( ~r/__([^_]+)__/, "<strong>\\1</strong>")
    |> String.replace( ~r/_([^_]+)_/, "<em>\\1</em>")
  end

  defp patch(l) do
    l
    |> String.replace("<li>", "<ul><li>", global: false)
    |> String.replace_suffix("</li>", "</li></ul>")
  end
end
