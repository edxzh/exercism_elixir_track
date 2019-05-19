defmodule SecretHandshake do
  use Bitwise

  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    code
    |> Integer.digits(2)
    |> Enum.reverse
    |> Enum.with_index
    |> Enum.map(&process/1)
    |> Enum.filter(& &1)
    |> reverse

  end

  defp process({1, 0}), do: "wink"
  defp process({1, 1}), do: "double blink"
  defp process({1, 2}), do: "close your eyes"
  defp process({1, 3}), do: "jump"
  defp process({1, 4}), do: "reverse"
  defp process({_, _}), do: nil

  defp reverse(secret_handshake) do
    case Enum.at(secret_handshake, -1) do
      "reverse" -> secret_handshake |> Enum.drop(-1) |> Enum.reverse
      _ -> secret_handshake
    end
  end
end
