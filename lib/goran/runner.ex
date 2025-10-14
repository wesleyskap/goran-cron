defmodule Goran.Runner do
  @moduledoc """
  Executes jobs asynchronously in supervised Tasks.
  """
  alias Goran.Job

  def run_job(%Job{} = job) do
    Task.Supervisor.async_nolink(Goran.TaskSupervisor, fn ->
      execute_task(job.task)
    end)
  end

  defp execute_task(fun) when is_function(fun, 0), do: fun.()
  defp execute_task({mod, fun, args}), do: apply(mod, fun, args)
end