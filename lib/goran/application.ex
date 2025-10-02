defmodule Goran.Application do
  @moduledoc false
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Registry, keys: :unique, name: Goran.Registry},
      {DynamicSupervisor, strategy: :one_for_one, name: Goran.TaskSupervisor}
    ]

    opts = [strategy: :one_for_one, name: Goran.Supervisor]
    Supervisor.start_link(children, opts)
  end
end