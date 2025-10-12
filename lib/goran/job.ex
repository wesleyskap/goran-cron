defmodule Goran.Job do
  @moduledoc """
  Defines a scheduled recurring routine.
  """
  alias Goran.Parser

  defstruct [
    :name,
    :schedule,
    :cron,
    :task,
    :timeout_ms,
    :overlap,
    :last_run_at
  ]

  @default_timeout_ms 60_000

  def new(name, schedule, task, opts \\ []) when is_function(task, 0) or is_tuple(task) do
    with {:ok, cron} <- Parser.parse(schedule) do
      {:ok, %__MODULE__{
        name: name,
        schedule: schedule,
        cron: cron,
        task: task,
        timeout_ms: Keyword.get(opts, :timeout_ms, @default_timeout_ms),
        overlap: Keyword.get(opts, :overlap, false),
        last_run_at: nil
      }}
    end
  end
end