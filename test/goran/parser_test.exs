defmodule Goran.ParserTest do
  use ExUnit.Case, async: true
  alias Goran.Parser

  test "parses standard every 5 minutes cron expression" do
    assert {:ok, cron} = Parser.parse("*/5 * * * *")
    assert length(cron.minutes) == 12
    assert length(cron.hours) == 24
  end
end