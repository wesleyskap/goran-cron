defmodule Goran.Parser.DefaultSecondTest do
  use ExUnit.Case, async: true
  alias Goran.Parser

  test "defaults seconds to [0] for standard 5 field crons" do
    assert {:ok, cron} = Parser.parse("* * * * *")
    assert cron.seconds == [0]
  end
end