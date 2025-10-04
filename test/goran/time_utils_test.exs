defmodule Goran.TimeUtilsTest do
  use ExUnit.Case, async: true
  alias Goran.TimeUtils

  test "truncates milliseconds from current time" do
    now = TimeUtils.now_utc()
    assert now.microsecond == {0, 0}
  end
end