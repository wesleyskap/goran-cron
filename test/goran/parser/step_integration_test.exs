defmodule Goran.Parser.StepIntegrationTest do
  use ExUnit.Case, async: true
  alias Goran.Parser.Field

  test "parses wildcard with step */15" do
    assert {:ok, [0, 15, 30, 45]} = Field.parse("*/15", 0, 59)
  end

  test "parses range with step 10-20/5" do
    assert {:ok, [10, 15, 20]} = Field.parse("10-20/5", 0, 59)
  end
end