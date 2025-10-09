defmodule Goran.Matcher do
  @moduledoc """
  Matches timestamps against parsed cron schedules.
  """
  alias Goran.Parser

  def match?(%Parser{} = cron, %DateTime{} = dt) do
    match_second?(cron, dt.second) and match_minute?(cron, dt.minute)
  end

  defp match_second?(cron, s), do: s in cron.seconds
  defp match_minute?(cron, m), do: m in cron.minutes
end