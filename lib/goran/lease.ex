defmodule Goran.Lease do
  @moduledoc """
  Distributed lock manager ensuring single-node job execution.
  """
  alias Goran.Lease.{Store, Token}

  @table :goran_leases
  @default_ttl_ms 30_000

  def with_lease(job_name, ttl_ms \\ @default_ttl_ms, fun) when is_function(fun, 0) do
    case acquire(job_name, ttl_ms) do
      {:ok, token} ->
        try do
          res = fun.()
          {:ok, res}
        after
          release(job_name, token)
        end

      {:error, reason} -> {:error, reason}
    end
  end

  def acquire(job_name, ttl_ms \\ @default_ttl_ms) do
    Store.init_table()
    now = System.monotonic_time(:millisecond)
    expires_at = now + ttl_ms
    token = Token.generate()

    case :ets.lookup(@table, job_name) do
      [{^job_name, _old_tok, old_exp, _holder}] ->
        if Token.expired?(old_exp) do
          force_take(job_name, token, expires_at)
        else
          {:error, :locked}
        end

      [] ->
        if :ets.insert_new(@table, {job_name, token, expires_at, self()}) do
          {:ok, token}
        else
          {:error, :locked}
        end
    end
  end

  def renew(job_name, token, ttl_ms \\ @default_ttl_ms) do
    case :ets.lookup(@table, job_name) do
      [{^job_name, ^token, _exp, _holder}] ->
        new_exp = System.monotonic_time(:millisecond) + ttl_ms
        :ets.insert(@table, {job_name, token, new_exp, self()})
        :ok

      _ -> {:error, :not_owner}
    end
  end

  def release(job_name, token) do
    case :ets.lookup(@table, job_name) do
      [{^job_name, ^token, _exp, _holder}] ->
        :ets.delete(@table, job_name)
        :ok

      _ -> {:error, :not_owner}
    end
  end

  defp force_take(job_name, token, expires_at) do
    :ets.insert(@table, {job_name, token, expires_at, self()})
    {:ok, token}
  end
end