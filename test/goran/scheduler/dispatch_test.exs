defmodule Goran.Scheduler.DispatchTest do
  use ExUnit.Case, async: false
  alias Goran.{Job, TimeUtils}
  alias Goran.Scheduler.Dispatch

  test "evaluates job matching now" do
    {:ok, job} = Job.new(:ping_job, "* * * * * *", fn -> :pong end)
    now = TimeUtils.now_utc()
    updated = Dispatch.evaluate_and_run(%{ping_job: job}, now)
    assert updated.ping_job.last_run_at == now
  end
end