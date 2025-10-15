defmodule Goran.Scheduler.Dispatch do
  @moduledoc """
  Evaluates schedules and dispatches ready jobs respecting pause states.
  """
  alias Goran.{Matcher, Runner, Lease}
  alias Goran.Scheduler.Pause

  def evaluate_and_run(jobs, now) do
    Enum.reduce(jobs, jobs, fn {name, job}, acc ->
      if not Pause.paused?(job) and Matcher.match?(job.cron, now) and should_run?(job, now) do
        spawn_with_lease(name, job)
        Map.put(acc, name, %{job | last_run_at: now})
      else
        acc
      end
    end)
  end

  defp should_run?(job, now) do
    case job.last_run_at do
      nil -> true
      last -> DateTime.diff(now, last, :second) >= 1
    end
  end

  defp spawn_with_lease(name, job) do
    spawn(fn ->
      Lease.with_lease(name, job.timeout_ms, fn ->
        Runner.run_job(job)
      end)
    end)
  end
end