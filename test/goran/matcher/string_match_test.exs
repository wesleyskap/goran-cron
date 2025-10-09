defmodule Goran.Matcher.StringMatchTest do
  use ExUnit.Case, async: true
  alias Goran.Matcher

  test "matches directly from binary expression string" do
    {:ok, dt, _} = DateTime.from_iso8601("2025-10-09T12:00:00Z")
    assert Matcher.match?("0 12 * * *", dt)
    refute Matcher.match?("0 13 * * *", dt)
  end
end