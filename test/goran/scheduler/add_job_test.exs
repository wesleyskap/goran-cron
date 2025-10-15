defmodule Goran.Scheduler.AddJobTest do
  use ExUnit.Case, async: false
  alias Goran.Scheduler

  setup do
    {:ok, pid} = Scheduler.start_link()
    on_exit(fn -> if Process.alive?(pid), do: GenServer.stop(pid) end)
    %{pid: pid}
  end

  test "adds and lists registered job" do
    assert :ok == Scheduler.add_job(:daily_rep, "0 0 * * *", fn -> :ok end)
    jobs = Scheduler.list_jobs()
    assert length(jobs) == 1
    assert hd(jobs).name == :daily_rep
  end
end