defmodule XratedTest do
  use ExUnit.Case


  test "it can calculated expected score" do

    # equally likely
    assert Xrated.expected_score(150, 150) == 0.5

    # p1 likey to lose
    assert_in_delta Xrated.expected_score(100, 200), 0.36, 0.01
  end

  test "it can calculate ratings after a win" do

    # equal standings
    assert Xrated.calculate_rating_delta(150, 150, :win) == 20.0

    # p1 beats the odds
    assert_in_delta Xrated.calculate_rating_delta(100, 200, :win), 25.6, 0.01
  end

  test "it can calculate ratings after a tie" do

    # equal standings
    assert Xrated.calculate_rating_delta(150, 150, :tie) == 0

    # p1 beats the odds
    assert_in_delta Xrated.calculate_rating_delta(100, 200, :tie), 5.6, 0.01
  end
end
