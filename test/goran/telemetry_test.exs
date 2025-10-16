defmodule Goran.TelemetryTest do
  use ExUnit.Case, async: true
  alias Goran.Telemetry

  test "emits telemetry events safely" do
    assert :ok == Telemetry.job_dispatched(:t_job, "* * * * *")
    assert :ok == Telemetry.job_completed(:t_job, 15, :ok)
  end
end