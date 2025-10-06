defmodule Goran.Parser.Field do
  @moduledoc """
  Parses individual cron expression fields.
  """
  alias Goran.Parser.Step

  def parse(str, min, max) do
    if String.contains?(str, ",") do
      parse_list(str, min, max)
    else
      parse_segment(str, min, max)
    end
  end

  defp parse_list(str, min, max) do
    str
    |> String.split(",")
    |> Enum.reduce_while({:ok, []}, fn part, {:ok, acc} ->
      case parse_segment(part, min, max) do
        {:ok, vals} -> {:cont, {:ok, acc ++ vals}}
        error -> {:halt, error}
      end
    end)
    |> case do
      {:ok, list} -> {:ok, Enum.uniq(list) |> Enum.sort()}
      err -> err
    end
  end

  defp parse_segment("*", min, max), do: {:ok, Enum.to_list(min..max)}

  defp parse_segment(str, min, max) do
    cond do
      String.contains?(str, "/") -> parse_with_step(str, min, max)
      String.contains?(str, "-") -> parse_range(str, min, max)
      true -> parse_integer(str, min, max)
    end
  end

  defp parse_with_step(str, min, max) do
    case String.split(str, "/", parts: 2) do
      [base, step_str] ->
        with {:ok, base_list} <- parse_segment(base, min, max),
             {:ok, stepped} <- Step.parse_step(base_list, step_str) do
          {:ok, stepped}
        end

      _ -> {:error, :invalid_step}
    end
  end

  defp parse_range(str, min, max) do
    case String.split(str, "-", parts: 2) do
      [s_start, s_end] ->
        with {start_v, ""} <- Integer.parse(s_start),
             {end_v, ""} <- Integer.parse(s_end),
             true <- start_v >= min and end_v <= max and start_v <= end_v do
          {:ok, Enum.to_list(start_v..end_v)}
        else
          _ -> {:error, :invalid_range}
        end

      _ -> {:error, :invalid_range}
    end
  end

  defp parse_integer(str, min, max) do
    case Integer.parse(str) do
      {val, ""} when val >= min and val <= max -> {:ok, [val]}
      _ -> {:error, :invalid_field_value}
    end
  end
end