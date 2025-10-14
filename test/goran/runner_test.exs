defmodule Goran.RunnerTest do
  use ExUnit.Case, async: false
  alias Goran.{Job, Runner}

  test "runs job task asynchronously" do
    {:ok, job} = Job.new(:task_run, "* * * * *", fn -> 42 end)
    task = Runner.run_job(job)
    assert 42 == Task.await(task)
  end
end