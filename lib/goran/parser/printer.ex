defmodule Goran.Parser.Printer do
  @moduledoc """
  Formats parsed cron struct back into standard expression string.
  """
  alias Goran.Parser

  def print(%Parser{} = c) do
    m = format_list(c.minutes, 0, 59)
    h = format_list(c.hours, 0, 23)
    dom = format_list(c.days_of_month, 1, 31)
    mon = format_list(c.months, 1, 12)
    dow = format_list(c.days_of_week, 0, 6)

    "#{m} #{h} #{dom} #{mon} #{dow}"
  end

  defp format_list(list, min, max) do
    if length(list) == (max - min + 1) do
      "*"
    else
      Enum.join(list, ",")
    end
  end
end