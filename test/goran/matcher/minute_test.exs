defmodule Goran.Matcher.MinuteTest do
  use ExUnit.Case, async: true
  alias Goran.{Parser, Matcher}

  test "matches exact minute" do
    {:ok, cron} = Parser.parse("0 30 * * * *")
    {:ok, dt1, _} = DateTime.from_iso8601("2025-10-09T10:30:00Z")
    {:ok, dt2, _} = DateTime.from_iso8601("2025-10-09T10:31:00Z")
    assert Matcher.match?(cron, dt1)
    refute Matcher.match?(cron, dt2)
  end
end