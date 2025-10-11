defmodule Goran.Next.LeapYear do
  @moduledoc """
  Validates leap year day boundaries.
  """

  def leap_year?(year) do
    (rem(year, 4) == 0 and rem(year, 100) != 0) or rem(year, 400) == 0
  end

  def days_in_month(year, 2) do
    if leap_year?(year), do: 29, else: 28
  end

  def days_in_month(_year, month) when month in [4, 6, 9, 11], do: 30
  def days_in_month(_year, _month), do: 31
end