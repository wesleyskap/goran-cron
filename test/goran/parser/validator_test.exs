defmodule Goran.Parser.ValidatorTest do
  use ExUnit.Case, async: true
  alias Goran.Parser.Validator

  test "formats known parser errors cleanly" do
    msg = Validator.format_error(:invalid_field_count)
    assert String.contains?(msg, "must contain either 5 or 6 fields")
  end
end