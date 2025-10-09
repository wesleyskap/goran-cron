defmodule Goran.Matcher.MatchNowTest do
  use ExUnit.Case, async: true
  alias Goran.Matcher

  test "evaluates match_now without raising errors" do
    res = Matcher.match_now?("* * * * *")
    assert is_boolean(res)
  end
end