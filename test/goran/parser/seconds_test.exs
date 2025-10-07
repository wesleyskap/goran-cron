defmodule Goran.Parser.SecondsTest do
  use ExUnit.Case, async: true
  alias Goran.Parser

  test "parses 6-field expression accurately" do
    assert {:ok, cron} = Parser.parse("*/10 * * * * *")
    assert cron.seconds == [0, 10, 20, 30, 40, 50]
    assert length(cron.minutes) == 60
  end
end