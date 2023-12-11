defmodule War do
  @moduledoc """
    Documentation for `War`.
  """

  @doc """
    Function stub for deal/1 is given below. Feel free to add
    as many additional helper functions as you want.

    The tests for the deal function can be found in test/war_test.exs.
    You can add your five test cases to this file.

    Run the tester by executing 'mix test' from the war directory
    (the one containing mix.exs)
  """

  def deal(shuf) do
    {player1, player2} = Enum.split_every(shuf, length(shuf) / 2)
    play(player1, player2, [], [])
  end

  defp play([], player2, acc1, acc2), do: {acc1, acc2 ++ player2}
  defp play(player1, [], acc1, acc2), do: {acc1 ++ player1, acc2}
  defp play([card1 | rest1], [card2 | rest2], acc1, acc2) do
    case compare_cards(card1, card2) do
      :player1 ->
        play(rest1, rest2, acc1 ++ [card1, card2], acc2)
      :player2 ->
        play(rest1, rest2, acc1, acc2 ++ [card1, card2])
      :war ->
        {new_acc1, new_acc2} = war(rest1, rest2, [card1, card2], [], acc1, acc2)
        play(new_acc1, new_acc2, [], [])
    end
  end

  defp compare_cards(card1, card2) do
    rank(card1) > rank(card2)
  end

  defp rank(card) do
    rem(card - 1, 13) + 1
  end

  defp war(player1, player2, face_down, face_up, acc1, acc2) do
    [new_card1 | rest1] = player1
    [new_card2 | rest2] = player2
    new_face_down = face_down ++ [new_card1, new_card2]
    new_face_up = face_up ++ [new_card1, new_card2]

    case compare_cards(new_card1, new_card2) do
      :player1 ->
        {acc1 ++ new_face_up, acc2 ++ new_face_down ++ rest1 ++ rest2}
      :player2 ->
        {acc1 ++ new_face_down ++ rest1 ++ rest2, acc2 ++ new_face_up}
      :war ->
        war(rest1, rest2, new_face_down, new_face_up, acc1, acc2)
    end
  end
end
