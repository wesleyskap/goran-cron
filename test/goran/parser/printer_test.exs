defmodule Goran.Parser.PrinterTest do
  use ExUnit.Case, async: true
  alias Goran.{Parser, Parser.Printer}

  test "formats wildcard cron cleanly" do
    {:ok, cron} = Parser.parse("* * * * *")
    assert "* * * * *" == Printer.print(cron)
  end
end