defmodule Goran.Lease.Info do
  @moduledoc """
  Inspects active lease metadata.
  """
  alias Goran.Lease.Token

  @table :goran_leases

  def status(job_name) do
    case :ets.lookup(@table, job_name) do
      [{^job_name, _tok, exp, holder}] ->
        %{
          job_name: job_name,
          locked: not Token.expired?(exp),
          holder: holder,
          remaining_ms: max(0, exp - System.monotonic_time(:millisecond))
        }

      [] ->
        %{job_name: job_name, locked: false, holder: nil, remaining_ms: 0}
    end
  end
end