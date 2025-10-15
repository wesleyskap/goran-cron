defmodule Goran.SchedulerTest do
  use ExUnit.Case, async: false
  alias Goran.Scheduler

  test "starts scheduler process" do
    {:ok, pid} = Scheduler.start_link()
    assert Process.alive?(pid)
    GenServer.stop(pid)
  end
end