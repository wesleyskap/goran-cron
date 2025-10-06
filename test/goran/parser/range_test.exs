defmodule Goran.Parser.RangeTest do
  use ExUnit.Case, async: true
  alias Goran.Parser.Field

  test "parses valid range" do
    assert {:ok, [2, 3, 4]} = Field.parse("2-4", 1, 10)
  end

  test "rejects inverted range where start exceeds end" do
    assert {:error, :invalid_range} = Field.parse("5-2", 1, 10)
  end
end