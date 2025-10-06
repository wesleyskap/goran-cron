defmodule Goran.Parser.ListTest do
  use ExUnit.Case, async: true
  alias Goran.Parser.Field

  test "parses distinct comma separated list" do
    assert {:ok, [1, 5, 9]} = Field.parse("1,5,9", 0, 59)
  end

  test "deduplicates and sorts list items" do
    assert {:ok, [1, 2, 3, 5]} = Field.parse("5,1-3,2", 0, 59)
  end
end