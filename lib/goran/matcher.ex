defmodule Goran.Matcher do
  @moduledoc """
  Matches timestamps against parsed cron schedules.
  """
  alias Goran.Parser
  alias Goran.TimeUtils
  alias Goran.Matcher.DayRules

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

    s_ok = dt.second in cron.seconds
    m_ok = dt.minute in cron.minutes
    h_ok = dt.hour in cron.hours
    mo_ok = dt.month in cron.months
    d_ok = DayRules.matches_day?(cron.days_of_month, cron.days_of_week, dt.day, dow_norm)

    s_ok and m_ok and h_ok and mo_ok and d_ok
  end
end