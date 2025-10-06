defmodule Goran.Parser.Step do
  @moduledoc """
  Parses step expressions like */15 or 10-30/5.
  """

  def parse_step(base_list, step_str) do
    case Integer.parse(step_str) do
      {step, ""} when step > 0 ->
        {:ok, Enum.take_every(base_list, step)}

      _ -> {:error, :invalid_step_value}
    end
  end
end