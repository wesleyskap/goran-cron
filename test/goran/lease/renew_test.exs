defmodule Goran.Lease.RenewTest do
  use ExUnit.Case, async: false
  alias Goran.Lease

  test "renews active lease successfully" do
    assert {:ok, token} = Lease.acquire(:renew_job, 1_000)
    assert :ok == Lease.renew(:renew_job, token, 10_000)
  end
end