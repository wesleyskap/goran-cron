defmodule Goran.Parser do
  @moduledoc """
  Main parser entry point for cron expressions with optional seconds.
  """
  alias Goran.Parser.{Field, Aliases}

  defstruct [
    :seconds,
    :minutes,
    :hours,
    :days_of_month,
    :months,
    :days_of_week
  ]

  def parse(expr) when is_binary(expr) do
    parts = String.split(String.trim(expr), " ")
    case parts do
      [s, m, h, dom, mon, dow] ->
        parse_6_field(s, m, h, dom, mon, dow)

      [m, h, dom, mon, dow] ->
        parse_5_field(m, h, dom, mon, dow)

      _ -> {:error, :invalid_field_count}
    end
  end

  defp parse_5_field(m, h, dom, mon, dow) do
    parse_6_field("0", m, h, dom, mon, dow)
  end

  defp parse_6_field(s, m, h, dom, mon, dow) do
    mon_norm = Aliases.normalize_month(mon)
    dow_norm = Aliases.normalize_day(dow)

    with {:ok, seconds} <- Field.parse(s, 0, 59),
         {:ok, minutes} <- Field.parse(m, 0, 59),
         {:ok, hours} <- Field.parse(h, 0, 23),
         {:ok, doms} <- Field.parse(dom, 1, 31),
         {:ok, months} <- Field.parse(mon_norm, 1, 12),
         {:ok, dows} <- Field.parse(dow_norm, 0, 7) do
      {:ok, %__MODULE__{
        seconds: seconds,
        minutes: minutes,
        hours: hours,
        days_of_month: doms,
        months: months,
        days_of_week: normalize_dows(dows)
      }}
    end
  end

  defp normalize_dows(dows) do
    dows
    |> Enum.map(fn d -> if d == 7, do: 0, else: d end)
    |> Enum.uniq()
    |> Enum.sort()
  end
end