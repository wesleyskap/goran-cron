defmodule Goran.ConfigTest do
  use ExUnit.Case, async: true
  alias Goran.Config

  test "returns standard configuration defaults" do
    assert Config.lease_ttl_ms() == 30_000
    assert Config.poll_interval_ms() == 1_000
  end
end