defmodule Goran.TimeUtils do
  @moduledoc """
  Time truncation and second boundary utilities.
  """

  def truncate_to_second(%DateTime{} = dt) do
    DateTime.truncate(dt, :second)
  end

  def now_utc do
    DateTime.utc_now() |> truncate_to_second()
  end
end