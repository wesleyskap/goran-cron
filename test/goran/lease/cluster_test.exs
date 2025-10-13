defmodule Goran.Lease.ClusterTest do
  use ExUnit.Case, async: false
  alias Goran.Lease.Cluster

  test "locks and unlocks via global module" do
    assert {:ok, id} = Cluster.lock(:cluster_task_1)
    assert :ok == Cluster.unlock(id)
  end
end