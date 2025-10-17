defmodule Goran.Facade.MatchNowTest do
  use ExUnit.Case, async: true

  test "evaluates match_now via facade" do
    assert is_boolean(Goran.match_now?("* * * * *"))
  end
end