defmodule Goran.ApplicationTest do
  use ExUnit.Case, async: true

  test "starts registry and task supervisor" do
    assert Process.whereis(Goran.Registry) != nil
    assert Process.whereis(Goran.TaskSupervisor) != nil
  end
end