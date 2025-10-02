# Goran Cron

Distributed cluster-wide job scheduler and cron execution engine for Elixir and Erlang/OTP 27.

## Key Features

- **Pure Elixir Cron Engine**: Zero-dependency parser for standard 5-field and extended 6-field cron expressions.
- **Distributed Lease Locks**: Coordination using native BEAM :global registry and lease timeouts.
- **Resilient Execution**: Isolated task execution supervised under dynamic OTP process trees.
- **Telemetry Ready**: Complete instrumentation for job lifecycles and miss warnings.
