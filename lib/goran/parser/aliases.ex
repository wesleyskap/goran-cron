defmodule Goran.Parser.Aliases do
  @moduledoc """
  Maps textual cron aliases to standard numeric equivalents.
  """

  @months %{
    "JAN" => "1", "FEB" => "2", "MAR" => "3", "APR" => "4",
    "MAY" => "5", "JUN" => "6", "JUL" => "7", "AUG" => "8",
    "SEP" => "9", "OCT" => "10", "NOV" => "11", "DEC" => "12"
  }

  def normalize(str) do
    Enum.reduce(@months, String.upcase(str), fn {text, num}, acc ->
      String.replace(acc, text, num)
    end)
  end
end