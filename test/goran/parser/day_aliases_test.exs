defmodule Goran.Parser.DayAliasesTest do
  use ExUnit.Case, async: true
  alias Goran.Parser.Aliases

  test "normalizes days of week strings" do
    assert "1-5" == Aliases.normalize_day("MON-FRI")
  end
end