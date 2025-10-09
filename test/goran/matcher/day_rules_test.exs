defmodule Goran.Matcher.DayRulesTest do
  use ExUnit.Case, async: true
  alias Goran.Matcher.DayRules

  test "verifies day rules combinations" do
    assert DayRules.matches_day?([1], [0], 1, 3)
    assert DayRules.matches_day?([1], [0], 5, 0)
    refute DayRules.matches_day?([1], [0], 5, 3)
  end
end