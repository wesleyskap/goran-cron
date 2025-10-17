defmodule Goran.Lease.InfoTest do
  use ExUnit.Case, async: false
  alias Goran.Lease
  alias Goran.Lease.Info

  test "reports lease metadata correctly" do
    {:ok, _} = Lease.acquire(:inspect_job, 5_000)
    info = Info.status(:inspect_job)
    assert info.locked == true
    assert info.remaining_ms > 0
  end
end