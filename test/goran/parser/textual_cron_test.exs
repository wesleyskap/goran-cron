defmodule Goran.Parser.TextualCronTest do
  use ExUnit.Case, async: true
  alias Goran.Parser

  test "parses cron with text aliases" do
    assert {:ok, cron} = Parser.parse("0 12 * JAN-MAR MON-FRI")
    assert cron.months == [1, 2, 3]
    assert cron.days_of_week == [1, 2, 3, 4, 5]
  end
end