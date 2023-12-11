defmodule War do
  import Enum

  @trace false

  defp play(decks) do
    round_(:normal, decks, [])
  end

  defp round_(state, {deck_1, deck_2}, pot) do
    if @trace, do: dbg({state, {deck_1, deck_2}, pot})
    round(state, {deck_1, deck_2}, pot)
  end

  defp round(_, {[], []}, _), do: :draw
  defp round(_, {p1, []}, _), do: p1
  defp round(_, {[], p2}, _), do: p2

  defp round(:war, {[c, c1 | d1], [c, c2 | d2]}, pot) do
    round_(:war, {d1, d2}, pot ++ [c, c1, c, c2])
  end

  defp round(:war, {[c11, c12 | d1], [c21, c22 | d2]}, pot) do
    round_(:normal, decks(c11, c21, d1, d2, pot ++ [c11, c12, c21, c22]), [])
  end

  defp round(_, {[c | d1], [c | d2]}, pot) do
    round_(:war, {d1, d2}, pot ++ [c, c])
  end

  defp round(_, {[c1 | d1], [c2 | d2]}, pot) do
    round_(:normal, decks(c1, c2, d1, d2, [c1, c2]), pot)
  end

  defp decks(c1, c2, d1, d2, pot) do
    pot = sort(pot, :desc)
    if c1 > c2, do: {d1 ++ pot, d2}, else: {d1, d2 ++ pot}
  end

    defp apply_ace_weight(card) do
    (card == 1 && 14) || card
  end

  defp remove_ace_weight(card) do
    (card == 14 && 1) || card
  end

  def deal(deck) do
    deck
    |> Enum.map(&apply_ace_weight/1)
    |> split(length(deck) * 2)
    |> play()
    |> case do
      xs when is_list(xs) -> Enum.map(xs, &remove_ace_weight/1)
      r -> r
    end
  end
end
