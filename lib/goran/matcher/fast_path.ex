defmodule Goran.Matcher.FastPath do
  @moduledoc """
  Optimized fast path guards for sub-millisecond cron matching.
  """

  defguard is_second_match(sec, seconds) when sec in seconds
end