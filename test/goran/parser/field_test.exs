defmodule Goran.Parser.FieldTest do
  use ExUnit.Case, async: true
  alias Goran.Parser.Field

  test "parses integers within range" do
    assert {:ok, 5} == Field.parse_integer("5", 0, 59)
    assert {:error, :invalid_field_value} == Field.parse_integer("65", 0, 59)
    assert {:error, :invalid_field_value} == Field.parse_integer("abc", 0, 59)
  end
end