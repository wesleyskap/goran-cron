defmodule Goran.Lease.Monitor do
  @moduledoc """
  Cleans leases held by crashed processes.
  """
  @table :goran_leases

  def prune_dead_holders do
    if :ets.info(@table) != :undefined do
      match_spec = [{{:"`$1", :_, :_, :"`$2"}, [], [{{:"`$1", :"`$2"}}]}]
      entries = :ets.select(@table, match_spec)

      Enum.each(entries, fn {job_name, holder_pid} ->
        if is_pid(holder_pid) and not Process.alive?(holder_pid) do
          :ets.delete(@table, job_name)
        end
      end)
    end
    :ok
  end
end