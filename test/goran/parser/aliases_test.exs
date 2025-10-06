defmodule Goran.Parser.AliasesTest do
  use ExUnit.Case, async: true
  alias Goran.Parser.Aliases

  test "replaces textual month names with numbers" do
    assert "1" == Aliases.normalize("JAN")
    assert "1-3" == Aliases.normalize("JAN-MAR")
  end
end