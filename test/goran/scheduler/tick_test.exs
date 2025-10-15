defmodule Goran.Scheduler.TickTest do
  use ExUnit.Case, async: false
  alias Goran.Scheduler

  setup do
    {:ok, pid} = Scheduler.start_link()
    on_exit(fn -> if Process.alive?(pid), do: GenServer.stop(pid) end)
    %{pid: pid}
  end

  test "receives poll_tick message cleanly" do
    send(Scheduler, :poll_tick)
    assert is_list(Scheduler.list_jobs())
  end
end