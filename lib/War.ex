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
    @ace_weight 14

    def deal(shuf) do
      {p1, p2} =
        shuf
        |> Enum.map(&apply_ace_weight/1)
        |> deal_deck()

      winner = play_game(p1, p2)

      Enum.map(winner, &remove_ace_weight/1)
    end

    def deal_deck(deck) do
      {Enum.take_every(deck, 2), Enum.drop_every(deck, 2)}
    end

    defp play_game(p1, p2, tied \\ [])

    defp play_game([], p2, tied), do: p2 ++ tied
    defp play_game(p1, [], tied), do: p1 ++ tied

    # War, cards tied
    defp play_game([c | xs], [c | ys], tied) do
      cards = Enum.sort([c, c] ++ tied, :desc)
      play_game(xs, ys, cards)
    end

    # Normal game turn
    defp play_game([x | xs], [y | ys], tied) do
      cards = Enum.sort([x, y] ++ tied, :desc)

      if x > y do
        play_game(xs ++ cards, ys)
      else
        play_game(xs, ys ++ cards)
      end
    end

    defp apply_ace_weight(card) do
      (card == 1 && @ace_weight) || card
    end

    defp remove_ace_weight(card) do
      (card == @ace_weight && 1) || card
    end
  end
