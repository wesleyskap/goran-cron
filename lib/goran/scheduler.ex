defmodule Goran.Scheduler do
  @moduledoc """
  Core GenServer managing cron schedules and execution timers.
  """
  use GenServer
  alias Goran.{Config, Job, TimeUtils, Runner, Lease}
  alias Goran.Scheduler.Dispatch

  defstruct [:jobs, :poll_timer]

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def add_job(name, schedule, task, opts \\ []) do
    GenServer.call(__MODULE__, {:add_job, name, schedule, task, opts})
  end

  def remove_job(name) do
    GenServer.call(__MODULE__, {:remove_job, name})
  end

  def run_now(name) do
    GenServer.call(__MODULE__, {:run_now, name})
  end

  def list_jobs do
    GenServer.call(__MODULE__, :list_jobs)
  end

  @impl true
  def init(_opts) do
    state = %__MODULE__{jobs: %{}, poll_timer: nil}
    schedule_poll(Config.poll_interval_ms())
    {:ok, state}
  end

  @impl true
  def handle_call({:add_job, name, schedule, task, opts}, _from, state) do
    case Job.new(name, schedule, task, opts) do
      {:ok, job} ->
        new_jobs = Map.put(state.jobs, name, job)
        {:reply, :ok, %{state | jobs: new_jobs}}

      {:error, reason} ->
        {:reply, {:error, reason}, state}
    end
  end

  @impl true
  def handle_call({:remove_job, name}, _from, state) do
    new_jobs = Map.delete(state.jobs, name)
    {:reply, :ok, %{state | jobs: new_jobs}}
  end

  @impl true
  def handle_call({:run_now, name}, _from, state) do
    case Map.get(state.jobs, name) do
      nil -> {:reply, {:error, :not_found}, state}
      job ->
        spawn(fn ->
          Lease.with_lease(name, job.timeout_ms, fn ->
            Runner.run_job(job)
          end)
        end)
        {:reply, :ok, state}
    end
  end

  @impl true
  def handle_call(:list_jobs, _from, state) do
    {:reply, Map.values(state.jobs), state}
  end

  @impl true
  def handle_info(:poll_tick, state) do
    now = TimeUtils.now_utc()
    new_jobs = Dispatch.evaluate_and_run(state.jobs, now)
    {:noreply, %{state | jobs: new_jobs}}
  end

  defp schedule_poll(interval) do
    :timer.send_interval(interval, :poll_tick)
  end
end