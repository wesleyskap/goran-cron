defmodule Goran.Matcher.DayTest do
  use ExUnit.Case, async: true
  alias Goran.{Parser, Matcher}

  test "matches day of week accurately" do
    # 2025-10-09 is Thursday (dow 4)
    {:ok, cron} = Parser.parse("0 0 0 * * 4")
    {:ok, dt, _} = DateTime.from_iso8601("2025-10-09T00:00:00Z")
    assert Matcher.match?(cron, dt)
  end
end