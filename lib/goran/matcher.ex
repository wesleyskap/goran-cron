defmodule Goran.Matcher do
  @moduledoc """
  Matches timestamps against parsed cron schedules.
  """
  alias Goran.Parser

  def match?(%Parser{} = cron, %DateTime{} = dt) do
    dow = Date.day_of_week(DateTime.to_date(dt))
    dow_norm = if dow == 7, do: 0, else: dow

    match_second?(cron, dt.second) and
      match_minute?(cron, dt.minute) and
      match_hour?(cron, dt.hour) and
      match_month?(cron, dt.month) and
      match_day?(cron, dt.day, dow_norm)
  end

  defp match_second?(cron, s), do: s in cron.seconds
  defp match_minute?(cron, m), do: m in cron.minutes
  defp match_hour?(cron, h), do: h in cron.hours
  defp match_month?(cron, mo), do: mo in cron.months

  defp match_day?(cron, dom, dow) do
    # When both day_of_month and day_of_week are specified (not all values),
    # standard cron treats them as union OR match.
    dom_all? = length(cron.days_of_month) == 31
    dow_all? = length(cron.days_of_week) == 7

    cond do
      dom_all? and dow_all? -> true
      dom_all? -> dow in cron.days_of_week
      dow_all? -> dom in cron.days_of_month
      true -> dom in cron.days_of_month or dow in cron.days_of_week
    end
  end
end