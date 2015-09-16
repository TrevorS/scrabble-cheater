defmodule ScrabbleCheater.Permutations do
  def permutations_of_powerset_of(letters) do
    powerset(letters)
    |> Enum.filter(&(length(&1) > 1))
    |> Enum.map(&permute/1)
    |> List.flatten
    |> Enum.uniq
  end

  defp permute(letters) do
    Comb.permutations(letters) |> Enum.map(&to_string/1)
  end

  defp powerset([]), do: [[]]
  defp powerset([h | t]) do
    pt = powerset(t)
    (for x <- pt, do: [h | x]) ++ pt
  end
end
