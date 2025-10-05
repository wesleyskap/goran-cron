defmodule Goran.Parser.Field do
  @moduledoc """
  Parses individual cron expression fields.
  """

  def parse_integer(str, min, max) do
    case Integer.parse(str) do
      {val, ""} when val >= min and val <= max -> {:ok, val}
      _ -> {:error, :invalid_field_value}
    end
  end
end