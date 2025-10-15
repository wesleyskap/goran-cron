defmodule Goran.Scheduler do
  @moduledoc """
  Core GenServer managing cron schedules and execution timers.
  """
  use GenServer
  alias Goran.Config

  defstruct [:jobs, :poll_timer]

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  @impl true
  def init(_opts) do
    state = %__MODULE__{jobs: %{}, poll_timer: nil}
    schedule_poll(Config.poll_interval_ms())
    {:ok, state}
  end

  defp schedule_poll(interval) do
    :timer.send_interval(interval, :poll_tick)
  end
end