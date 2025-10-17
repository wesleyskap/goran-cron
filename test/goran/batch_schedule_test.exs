defmodule Goran.BatchScheduleTest do
  use ExUnit.Case, async: false

  setup do
    {:ok, pid} = Goran.Scheduler.start_link()
    on_exit(fn -> if Process.alive?(pid), do: GenServer.stop(pid) end)
    %{pid: pid}
  end

  test "registers batch of schedules" do
    batch = [
      {:batch_1, "0 1 * * *", fn -> :b1 end},
      {:batch_2, "0 2 * * *", fn -> :b2 end}
    ]
    assert :ok == Goran.schedule_batch(batch)
    assert length(Goran.jobs()) == 2
  end
end