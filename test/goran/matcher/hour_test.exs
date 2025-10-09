defmodule Goran.Matcher.HourTest do
  use ExUnit.Case, async: true
  alias Goran.{Parser, Matcher}

  test "matches scheduled hour" do
    {:ok, cron} = Parser.parse("0 0 14 * * *")
    {:ok, dt, _} = DateTime.from_iso8601("2025-10-09T14:00:00Z")
    assert Matcher.match?(cron, dt)
  end
end