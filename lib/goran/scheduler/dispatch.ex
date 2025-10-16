defmodule Goran.Scheduler.Dispatch do
  @moduledoc """
  Evaluates schedules and dispatches ready jobs with telemetry.
  """
  alias Goran.{Matcher, Runner, Lease, Telemetry}
  alias Goran.Scheduler.Pause

  def evaluate_and_run(jobs, now) do
    entries = Map.to_list(jobs)
    do_eval(entries, now, jobs)
  end

  defp do_eval([], _now, acc), do: acc

  defp do_eval([{name, job} | rest], now, acc) do
    if not Pause.paused?(job) and Matcher.match?(job.cron, now) and should_run?(job, now) do
      Telemetry.job_dispatched(name, job.schedule)
      spawn_with_lease(name, job)
      do_eval(rest, now, Map.put(acc, name, %{job | last_run_at: now}))
    else
      do_eval(rest, now, acc)
    end
  end

  defp should_run?(job, now) do
    case job.last_run_at do
      nil -> true
      last -> DateTime.diff(now, last, :second) >= 1
    end
  end

  defp spawn_with_lease(name, job) do
    spawn(fn ->
      start_ms = System.monotonic_time(:millisecond)
      Lease.with_lease(name, job.timeout_ms, fn ->
        task = Runner.run_job(job)
        res = Task.await(task, job.timeout_ms)
        dur = System.monotonic_time(:millisecond) - start_ms
        Telemetry.job_completed(name, dur, res)
        res
      end)
    end)
  end
end