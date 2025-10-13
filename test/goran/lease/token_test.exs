defmodule Goran.Lease.TokenTest do
  use ExUnit.Case, async: true
  alias Goran.Lease.Token

  test "generates unique hexadecimal tokens" do
    t1 = Token.generate()
    t2 = Token.generate()
    assert String.length(t1) == 32
    assert t1 != t2
  end

  test "evaluates expiration accurately" do
    past = Token.compute_expires_at(-10)
    future = Token.compute_expires_at(10_000)
    assert Token.expired?(past)
    refute Token.expired?(future)
  end
end