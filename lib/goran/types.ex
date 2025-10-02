defmodule Goran.Types do
  @moduledoc """
  Domain types for cron scheduling and execution.
  """

  @type cron_expr :: binary()
  @type job_name :: atom() | binary()
  @type task_fun :: (-> term()) | {module(), atom(), list()}
  @type lease_state :: :acquired | :held | :released | :expired
  @type schedule_result :: :ok | {:error, term()}
end