defmodule Goran.Scheduler.RemoveJobTest do
  use ExUnit.Case, async: false
  alias Goran.Scheduler

  setup do
    {:ok, pid} = Scheduler.start_link()
    on_exit(fn -> if Process.alive?(pid), do: GenServer.stop(pid) end)
    %{pid: pid}
  end

  test "removes job cleanly" do
    Scheduler.add_job(:temp_job, "* * * * *", fn -> :ok end)
    assert :ok == Scheduler.remove_job(:temp_job)
    assert [] == Scheduler.list_jobs()
  end
end