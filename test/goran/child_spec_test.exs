defmodule Goran.ChildSpecTest do
  use ExUnit.Case, async: true

  test "returns valid child spec" do
    spec = Goran.child_spec([])
    assert spec.id == Goran
    assert spec.type == :worker
  end
end