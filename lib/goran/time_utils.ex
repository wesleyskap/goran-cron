defmodule Goran.TimeUtils do
  @moduledoc """
  Time truncation and second boundary utilities.
  """

  def truncate_to_second(%DateTime{} = dt) do
    %{dt | microsecond: {0, 0}}
  end

  def now_utc do
    DateTime.utc_now() |> truncate_to_second()
  end
end