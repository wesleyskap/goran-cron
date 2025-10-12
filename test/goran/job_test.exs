defmodule Goran.JobTest do
  use ExUnit.Case, async: true
  alias Goran.Job

  test "creates valid job struct" do
    assert {:ok, job} = Job.new(:nightly_clean, "0 2 * * *", fn -> :cleaned end)
    assert job.name == :nightly_clean
    assert job.overlap == false
  end

  test "fails with invalid cron schedule" do
    assert {:error, _} = Job.new(:bad, "invalid cron", fn -> :ok end)
  end
end