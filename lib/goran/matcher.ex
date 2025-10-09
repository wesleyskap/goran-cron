defmodule Goran.Matcher do
  @moduledoc """
  Matches timestamps against parsed cron schedules.
  """
  alias Goran.Parser
  alias Goran.TimeUtils

  def match_now?(cron_or_expr) do
    match?(cron_or_expr, TimeUtils.now_utc())
  end

  def match?(expr, dt) when is_binary(expr) do
    case Parser.parse(expr) do
      {:ok, cron} -> match?(cron, dt)
      _ -> false
    end
  end

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