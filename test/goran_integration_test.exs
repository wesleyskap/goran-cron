defmodule GoranIntegrationTest do
  use ExUnit.Case, async: false

  setup do
    {:ok, pid} = Goran.Scheduler.start_link()
    on_exit(fn -> if Process.alive?(pid), do: GenServer.stop(pid) end)
    %{pid: pid}
  end

  test "executes full lifecycle: parse, schedule, lease, and trigger" do
    assert :ok == Goran.validate("*/15 * * * *")
    assert :ok == Goran.schedule(:integ_task, "* * * * *", fn -> :success end)
    assert length(Goran.jobs()) == 1
    assert :ok == Goran.trigger(:integ_task)
    assert :ok == Goran.unschedule(:integ_task)
    assert Enum.empty?(Goran.jobs())
  end
end