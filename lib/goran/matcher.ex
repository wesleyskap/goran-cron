defmodule Goran.Matcher do
  @moduledoc """
  Matches timestamps against parsed cron schedules.
  """
  alias Goran.Parser

  def match?(%Parser{} = cron, %DateTime{} = dt) do
    match_second?(cron, dt.second) and
      match_minute?(cron, dt.minute) and
      match_hour?(cron, dt.hour) and
      match_month?(cron, dt.month)
  end

  defp match_second?(cron, s), do: s in cron.seconds
  defp match_minute?(cron, m), do: m in cron.minutes
  defp match_hour?(cron, h), do: h in cron.hours
  defp match_month?(cron, mo), do: mo in cron.months
end