defmodule Goran.Lease.Token do
  @moduledoc """
  Generates lease tokens and computes expiration timestamps.
  """

  def generate do
    :crypto.strong_rand_bytes(16) |> Base.encode16(case: :lower)
  end

  def compute_expires_at(ttl_ms) do
    System.monotonic_time(:millisecond) + ttl_ms
  end

  def expired?(expires_at) do
    System.monotonic_time(:millisecond) >= expires_at
  end
end