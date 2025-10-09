defmodule Goran.Matcher.DayRules do
  @moduledoc """
  Encapsulates cron day of week and day of month union matching.
  """

  def matches_day?(doms, dows, dom, dow) do
    dom_all? = length(doms) == 31
    dow_all? = length(dows) == 7

    cond do
      dom_all? and dow_all? -> true
      dom_all? -> dow in dows
      dow_all? -> dom in doms
      true -> dom in doms or dow in dows
    end
  end
end