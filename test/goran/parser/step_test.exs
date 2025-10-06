defmodule Goran.Parser.StepTest do
  use ExUnit.Case, async: true
  alias Goran.Parser.Step

  test "steps every N elements" do
    base = [0, 1, 2, 3, 4, 5]
    assert {:ok, [0, 2, 4]} == Step.parse_step(base, "2")
  end
end