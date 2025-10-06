defmodule Goran.Parser.WildcardTest do
  use ExUnit.Case, async: true
  alias Goran.Parser.Field

  test "expands wildcard to complete range list" do
    assert {:ok, list} = Field.parse("*", 1, 5)
    assert list == [1, 2, 3, 4, 5]
  end
end