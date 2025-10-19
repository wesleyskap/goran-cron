# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2025-10-19

### Added
- Standard 5-field and 6-field cron expression parser (``Goran.Parser``).
- Real-time cron timestamp matching engine (``Goran.Matcher``).
- Forward calculation of next execution timestamps (``Goran.Next``).
- Cluster-wide lease lock coordinator with :global and ETS (``Goran.Lease``).
- Dynamic task supervision and execution runner (``Goran.Runner``).
- Root scheduler GenServer with poll interval dispatch loop (``Goran.Scheduler``).
- Telemetry event emitter for schedule and run lifecycle (``Goran.Telemetry``).
- Top-level unified facade (``Goran``).

## [0.1.0] - 2025-10-02

### Added
- Project foundation, build configuration, and documentation.
