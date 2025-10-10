defmodule Goran.Next do
  @moduledoc """
  Calculates next execution DateTime for a cron expression.
  """
  alias Goran.Matcher

  @max_search_seconds 366 * 86400

  def find_next(cron, %DateTime{} = from_dt) do
    search(cron, DateTime.add(from_dt, 1, :second), 0)
  end

  defp search(_cron, _curr, count) when count >= @max_search_seconds do
    {:error, :no_matching_time_found}
  end

  defp search(cron, curr, count) do
    if Matcher.match?(cron, curr) do
      {:ok, curr}
    else
      search(cron, DateTime.add(curr, 1, :second), count + 1)
    end
  end
end