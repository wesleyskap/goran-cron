defmodule Goran.Facade.ValidateTest do
  use ExUnit.Case, async: true

  test "validates expressions" do
    assert :ok == Goran.validate("0 * * * *")
    assert {:error, _} = Goran.validate("bad syntax")
  end
end