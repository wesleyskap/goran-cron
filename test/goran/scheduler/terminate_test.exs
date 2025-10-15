defmodule Goran.Scheduler.TerminateTest do
  use ExUnit.Case, async: false
  alias Goran.Scheduler

  test "terminates cleanly without crashing" do
    {:ok, pid} = Scheduler.start_link()
    assert :ok == GenServer.stop(pid)
  end
end