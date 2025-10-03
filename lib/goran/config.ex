defmodule Goran.Config do
  @moduledoc """
  Centralized configuration for default lease TTL and poll ticks.
  """

  @default_lease_ttl_ms 30_000
  @default_poll_interval_ms 1_000

  @spec lease_ttl_ms() :: pos_integer()
  def lease_ttl_ms do
    Application.get_env(:goran, :lease_ttl_ms, @default_lease_ttl_ms)
  end

  @spec poll_interval_ms() :: pos_integer()
  def poll_interval_ms do
    Application.get_env(:goran, :poll_interval_ms, @default_poll_interval_ms)
  end
end