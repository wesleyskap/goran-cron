defmodule Goran.LeaseTest do
  use ExUnit.Case, async: false
  alias Goran.Lease

  test "acquires lease successfully and rejects concurrent collision" do
    assert {:ok, token} = Lease.acquire(:test_job_1, 5_000)
    assert is_binary(token)
    assert {:error, :locked} = Lease.acquire(:test_job_1, 5_000)
  end
end