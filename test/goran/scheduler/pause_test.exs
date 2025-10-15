defmodule Goran.Scheduler.PauseTest do
  use ExUnit.Case, async: true
  alias Goran.Scheduler.Pause

  test "pauses and resumes job state" do
    job = %{name: :j1, paused: false}
    p_job = Pause.pause_job(job)
    assert Pause.paused?(p_job)
    r_job = Pause.resume_job(p_job)
    refute Pause.paused?(r_job)
  end
end