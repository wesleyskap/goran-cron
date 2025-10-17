defmodule Goran do
  @moduledoc """
  Main entry point for Goran cron scheduling and lease management.
  """
  alias Goran.{Scheduler, Parser, Matcher, Next, Lease}
  alias Goran.Lease.Info
  alias Goran.Parser.Printer

  def child_spec(opts) do
    %{
      id: __MODULE__,
      start: {Scheduler, :start_link, [opts]},
      type: :worker,
      restart: :permanent
    }
  end

  def schedule_batch(job_definitions) when is_list(job_definitions) do
    Enum.each(job_definitions, fn {name, expr, task} ->
      schedule(name, expr, task)
    end)
    :ok
  end

  def lease_status(name), do: Info.status(name)
  def format(%Parser{} = cron), do: Printer.print(cron)

  defdelegate schedule(name, cron_expr, task, opts \\ []), to: Scheduler, as: :add_job
  defdelegate unschedule(name), to: Scheduler, as: :remove_job
  defdelegate jobs, to: Scheduler, as: :list_jobs
  defdelegate trigger(name), to: Scheduler, as: :run_now
  defdelegate parse(expr), to: Parser, as: :parse
  defdelegate validate(expr), to: Parser, as: :validate
  defdelegate match?(cron_or_expr, dt), to: Matcher, as: :match?
  defdelegate match_now?(cron_or_expr), to: Matcher, as: :match_now?
  defdelegate next(cron, from_dt), to: Next, as: :find_next
  defdelegate with_lease(name, ttl_ms \\ 30_000, fun), to: Lease, as: :with_lease
end