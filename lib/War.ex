defmodule War do
  def deal(shuf) do
  [player1, player2] = deal_cards(shuf)
  play_rounds(player1, player2)
  end

  def deal_cards(shuf) do
  shuf |> Enum.chunk_every(26)
  end

  def play_rounds(player1, player2) do
  case {player1, player2} do
  {[], []} →
  {:tie, []}

    {[], player2_deck} ->
      {:player2, player2_deck}

    {player1_deck, []} ->
      {:player1, player1_deck}

    {[card1 | hand1_without_card], [card2 | hand2_without_card]} ->
      case compare_cards(card1, card2) do
        :win ->
          play_rounds(hand1_without_card ++ [card1, card2], hand2_without_card)

        :lose ->
          play_rounds(hand1_without_card, hand2_without_card ++ [card1, card2])

        :tie ->
          play_war(hand1_without_card, hand2_without_card, [card1, card2])
      end
  end
