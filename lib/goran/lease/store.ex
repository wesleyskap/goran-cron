defmodule Goran.Lease.Store do
  @moduledoc """
  Local storage engine for lease metadata.
  """
  @table :goran_leases

  def init_table do
    if :ets.info(@table) == :undefined do
      :ets.new(@table, [:named_table, :set, :public, read_concurrency: true])
    end
    :ok
  end
end