defmodule Goran.Next.LeapYearTest do
  use ExUnit.Case, async: true
  alias Goran.Next.LeapYear

  test "verifies 2024 is leap and 2025 is not" do
    assert LeapYear.leap_year?(2024)
    refute LeapYear.leap_year?(2025)
    assert 29 == LeapYear.days_in_month(2024, 2)
    assert 28 == LeapYear.days_in_month(2025, 2)
  end
end