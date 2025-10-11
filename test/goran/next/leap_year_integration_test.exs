defmodule Goran.Next.LeapYearIntegrationTest do
  use ExUnit.Case, async: true
  alias Goran.{Parser, Next}

  test "finds next schedule spanning month boundary" do
    {:ok, cron} = Parser.parse("0 0 1 * *")
    {:ok, dt, _} = DateTime.from_iso8601("2025-10-31T23:59:59Z")
    assert {:ok, next_dt} = Next.find_next(cron, dt)
    assert next_dt.day == 1
    assert next_dt.month == 11
  end
end