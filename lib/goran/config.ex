defmodule Goran.Config do
  @moduledoc """
  Centralized configuration for default lease TTL and poll ticks.
  """

  @default_lease_ttl_ms 30_000
  @default_poll_interval_ms 1_000

  def lease_ttl_ms do
    Application.get_env(:goran, :lease_ttl_ms, @default_lease_ttl_ms)
  end

  def poll_interval_ms do
    Application.get_env(:goran, :poll_interval_ms, @default_poll_interval_ms)
  end
end