defmodule Goran.Scheduler.PauseDispatchTest do
  use ExUnit.Case, async: false
  alias Goran.{Job, TimeUtils}
  alias Goran.Scheduler.Dispatch

  test "skips execution of paused job" do
    {:ok, job} = Job.new(:paused_j, "* * * * * *", fn -> :ok end)
    paused = Map.put(job, :paused, true)
    now = TimeUtils.now_utc()
    res = Dispatch.evaluate_and_run(%{paused_j: paused}, now)
    assert res.paused_j.last_run_at == nil
  end
end