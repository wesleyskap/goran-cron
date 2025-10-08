defmodule Goran.Parser.Validator do
  @moduledoc """
  Detailed error messages for cron validation failures.
  """

  def format_error(:invalid_field_count), do: "expression must contain either 5 or 6 fields"
  def format_error(:invalid_field_value), do: "field contains values outside valid numerical range"
  def format_error(:invalid_range), do: "range start cannot exceed range end"
  def format_error(:invalid_step), do: "step denominator must be a positive integer"
  def format_error(other), do: "cron syntax error: #{inspect(other)}"
end