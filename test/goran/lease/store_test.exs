defmodule Goran.Lease.StoreTest do
  use ExUnit.Case, async: false
  alias Goran.Lease.Store

  test "initializes lease table" do
    assert :ok == Store.init_table()
    assert :ets.info(:goran_leases) != :undefined
  end
end