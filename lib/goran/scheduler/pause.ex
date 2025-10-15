defmodule Goran.Scheduler.Pause do
  @moduledoc """
  Tracks paused job states.
  """

  def paused?(job) do
    Map.get(job, :paused, false)
  end

  def pause_job(job), do: Map.put(job, :paused, true)
  def resume_job(job), do: Map.put(job, :paused, false)
end