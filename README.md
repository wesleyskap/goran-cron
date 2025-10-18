# Goran Cron

Distributed cluster-wide job scheduler and cron execution engine for Elixir and Erlang/OTP 27.

## Key Features

- **Pure Elixir Cron Engine**: Zero-dependency parser for standard 5-field and extended 6-field cron expressions.
- **Distributed Lease Locks**: Coordination using native BEAM :global registry and lease timeouts.
- **Resilient Execution**: Isolated task execution supervised under dynamic OTP process trees.
- **Telemetry Ready**: Complete instrumentation for job lifecycles and miss warnings.

## Cron Syntax Reference

| Field | Allowed Values | Special Characters |
| :--- | :--- | :--- |
| Seconds (optional) | 0-59 | ``*`` ``,`` ``-`` ``/`` |
| Minutes | 0-59 | ``*`` ``,`` ``-`` ``/`` |
| Hours | 0-23 | ``*`` ``,`` ``-`` ``/`` |
| Day of Month | 1-31 | ``*`` ``,`` ``-`` ``/`` |
| Month | 1-12 or JAN-DEC | ``*`` ``,`` ``-`` ``/`` |
| Day of Week | 0-6 (0=Sun) or SUN-SAT | ``*`` ``,`` ``-`` ``/`` |

## Installation

Add ``goran`` to your list of dependencies in ``mix.exs``:

``````elixir
def deps do
  [
    {:goran, "~> 1.0.0"}
  ]
end
``````

## Basic Usage

### Scheduling a Job

``````elixir
# Schedule a job every 5 minutes
Goran.schedule(:cache_flush, "*/5 * * * *", fn ->
  MyApp.Cache.flush()
end)

# Trigger manually if needed
Goran.trigger(:cache_flush)
``````

### Distributed Lease Locking

``````elixir
# Execute exclusively on one cluster node
Goran.with_lease(:database_vacuum, 60_000, fn ->
  MyApp.Repo.vacuum()
end)
``````
