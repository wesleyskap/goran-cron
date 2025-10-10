defmodule Goran.NextTest do
  use ExUnit.Case, async: true
  alias Goran.{Parser, Next}

  test "calculates next matching second" do
    {:ok, cron} = Parser.parse("* * * * * *")
    {:ok, base, _} = DateTime.from_iso8601("2025-10-10T12:00:00Z")
    assert {:ok, next_dt} = Next.find_next(cron, base)
    assert DateTime.diff(next_dt, base, :second) == 1
  end
end