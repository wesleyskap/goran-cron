defmodule Goran.Matcher do
  @moduledoc """
  Matches timestamps against parsed cron schedules.
  """
  alias Goran.Parser

  def match?(%Parser{} = cron, %DateTime{} = dt) do
    match_second?(cron, dt.second)
  end

  defp match_second?(cron, s), do: s in cron.seconds
end