defmodule Goran.Matcher.MonthTest do
  use ExUnit.Case, async: true
  alias Goran.{Parser, Matcher}

  test "matches current month" do
    {:ok, cron} = Parser.parse("0 0 0 * 10 *")
    {:ok, dt, _} = DateTime.from_iso8601("2025-10-09T00:00:00Z")
    assert Matcher.match?(cron, dt)
  end
end