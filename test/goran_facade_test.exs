defmodule GoranFacadeTest do
  use ExUnit.Case, async: true

  test "delegates parse and match cleanly" do
    assert {:ok, cron} = Goran.parse("*/5 * * * *")
    {:ok, dt, _} = DateTime.from_iso8601("2025-10-17T12:05:00Z")
    assert Goran.match?(cron, dt)
  end
end