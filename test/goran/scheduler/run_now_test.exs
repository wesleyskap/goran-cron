defmodule Goran.Scheduler.RunNowTest do
  use ExUnit.Case, async: false
  alias Goran.Scheduler

  setup do
    {:ok, pid} = Scheduler.start_link()
    on_exit(fn -> if Process.alive?(pid), do: GenServer.stop(pid) end)
    %{pid: pid}
  end

  test "manually triggers existing job" do
    parent = self()
    Scheduler.add_job(:manual_ping, "0 0 1 1 *", fn -> send(parent, :manual_pong) end)
    assert :ok == Scheduler.run_now(:manual_ping)
    assert_receive :manual_pong, 1_000
  end

  test "fails when triggering unknown job" do
    assert {:error, :not_found} == Scheduler.run_now(:ghost_job)
  end
end