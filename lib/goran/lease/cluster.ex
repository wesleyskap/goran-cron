defmodule Goran.Lease.Cluster do
  @moduledoc """
  Coordinates cluster-wide lease exclusivity using Erlang :global module.
  """

  def lock(name) do
    id = {:goran_lock, name}
    case :global.set_lock({id, self()}, [node() | Node.list()], 0) do
      true -> {:ok, id}
      false -> {:error, :cluster_locked}
    end
  end

  def unlock(id) do
    :global.del_lock({id, self()}, [node() | Node.list()])
    :ok
  end
end