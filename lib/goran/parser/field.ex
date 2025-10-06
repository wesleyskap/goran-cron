defmodule Goran.Parser.Field do
  @moduledoc """
  Parses individual cron expression fields.
  """

  def parse("*", min, max), do: {:ok, Enum.to_list(min..max)}

  def parse(str, min, max) do
    parse_integer(str, min, max)
  end

  defp parse_integer(str, min, max) do
    case Integer.parse(str) do
      {val, ""} when val >= min and val <= max -> {:ok, [val]}
      _ -> {:error, :invalid_field_value}
    end
  end
end