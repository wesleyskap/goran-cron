defmodule Goran do
  @moduledoc """
  Main entry point for Goran cron scheduling and lease management.
  """
  alias Goran.{Scheduler, Parser, Matcher, Next, Lease}

  defdelegate schedule(name, cron_expr, task, opts \\ []), to: Scheduler, as: :add_job
  defdelegate unschedule(name), to: Scheduler, as: :remove_job
  defdelegate jobs, to: Scheduler, as: :list_jobs
  defdelegate trigger(name), to: Scheduler, as: :run_now
  defdelegate parse(expr), to: Parser, as: :parse
  defdelegate match?(cron_or_expr, dt), to: Matcher, as: :match?
  defdelegate match_now?(cron_or_expr), to: Matcher, as: :match_now?
  defdelegate next(cron, from_dt), to: Next, as: :find_next
  defdelegate with_lease(name, ttl_ms \\ 30_000, fun), to: Lease, as: :with_lease
end