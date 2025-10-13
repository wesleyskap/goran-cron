defmodule Goran.Lease.MonitorTest do
  use ExUnit.Case, async: false
  alias Goran.Lease
  alias Goran.Lease.Monitor

  test "cleans lease held by terminated pid" do
    parent = self()
    child = spawn(fn ->
      {:ok, _} = Lease.acquire(:crashed_holder_job, 60_000)
      send(parent, :acquired)
    end)

    receive do: (:acquired -> :ok)
    Process.sleep(10)
    refute Process.alive?(child)

    Monitor.prune_dead_holders()
    assert {:ok, _} = Lease.acquire(:crashed_holder_job, 10_000)
  end
end