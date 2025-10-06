defmodule Goran.Parser do
  @moduledoc """
  Main parser entry point for cron expressions.
  """
  alias Goran.Parser.{Field, Aliases}

  defstruct [
    :minutes,
    :hours,
    :days_of_month,
    :months,
    :days_of_week
  ]

  def parse(expr) when is_binary(expr) do
    parts = String.split(String.trim(expr), " ")
    case parts do
      [m, h, dom, mon, dow] ->
        mon_norm = Aliases.normalize_month(mon)
        dow_norm = Aliases.normalize_day(dow)

        with {:ok, minutes} <- Field.parse(m, 0, 59),
             {:ok, hours} <- Field.parse(h, 0, 23),
             {:ok, doms} <- Field.parse(dom, 1, 31),
             {:ok, months} <- Field.parse(mon_norm, 1, 12),
             {:ok, dows} <- Field.parse(dow_norm, 0, 7) do
          dows_clean = normalize_dows(dows)
          {:ok, %__MODULE__{
            minutes: minutes,
            hours: hours,
            days_of_month: doms,
            months: months,
            days_of_week: dows_clean
          }}
        end

      _ -> {:error, :invalid_field_count}
    end
  end

  defp normalize_dows(dows) do
    dows
    |> Enum.map(fn d -> if d == 7, do: 0, else: d end)
    |> Enum.uniq()
    |> Enum.sort()
  end
end