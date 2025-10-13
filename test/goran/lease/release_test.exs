defmodule Goran.Lease.ReleaseTest do
  use ExUnit.Case, async: false
  alias Goran.Lease

  test "releases lock and allows new acquisition" do
    assert {:ok, token} = Lease.acquire(:rel_job, 10_000)
    assert :ok == Lease.release(:rel_job, token)
    assert {:ok, _} = Lease.acquire(:rel_job, 10_000)
  end

  test "rejects release with wrong token" do
    assert {:ok, _} = Lease.acquire(:sec_job, 10_000)
    assert {:error, :not_owner} = Lease.release(:sec_job, "bad_token")
  end
end