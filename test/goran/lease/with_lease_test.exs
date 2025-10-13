defmodule Goran.Lease.WithLeaseTest do
  use ExUnit.Case, async: false
  alias Goran.Lease

  test "executes block and automatically cleans up lease" do
    res = Lease.with_lease(:scoped_job, 5_000, fn -> 999 end)
    assert {:ok, 999} == res
    assert {:ok, _} = Lease.acquire(:scoped_job, 5_000)
  end
end