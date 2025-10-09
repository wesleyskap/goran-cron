defmodule Goran.Matcher.SecondTest do
  use ExUnit.Case, async: true
  alias Goran.{Parser, Matcher}

  test "matches exact second" do
    {:ok, cron} = Parser.parse("15 * * * * *")
    {:ok, dt, _} = DateTime.from_iso8601("2025-10-09T10:00:15Z")
    assert Matcher.match?(cron, dt)
  end
end