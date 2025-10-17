defmodule Goran.Facade.LeaseStatusTest do
  use ExUnit.Case, async: false

  test "retrieves lease status through facade" do
    status = Goran.lease_status(:unlocked_job)
    assert status.locked == false
  end
end