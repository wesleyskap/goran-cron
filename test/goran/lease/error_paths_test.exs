defmodule Goran.Lease.ErrorPathsTest do
  use ExUnit.Case, async: false
  alias Goran.Lease

  test "returns error when renewing non-existent lease" do
    assert {:error, :not_owner} == Lease.renew(:unknown_job, "any_token")
  end
end