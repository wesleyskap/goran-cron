defmodule Goran.Telemetry do
  @moduledoc """
  Telemetry emitter for Goran scheduler events.
  """

  def job_dispatched(name, schedule) do
    measurements = %{timestamp: System.system_time(:millisecond)}
    metadata = %{job_name: name, schedule: schedule}
    :telemetry.execute([:goran, :job, :dispatched], measurements, metadata)
  rescue
    UndefinedFunctionError -> :ok
  end

  def job_completed(name, duration_ms, result) do
    measurements = %{duration_ms: duration_ms}
    metadata = %{job_name: name, result: result}
    :telemetry.execute([:goran, :job, :completed], measurements, metadata)
  rescue
    UndefinedFunctionError -> :ok
  end
end