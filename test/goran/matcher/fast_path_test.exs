defmodule Goran.Matcher.FastPathTest do
  use ExUnit.Case, async: true
  import Goran.Matcher.FastPath

  test "validates guard macro functionality" do
    assert is_second_match(0, [0, 30])
  end
end