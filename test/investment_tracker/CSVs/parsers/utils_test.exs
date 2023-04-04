defmodule InvestmentTracker.CSVs.Parsers.UtilsTest do
  @moduledoc false
  use ExUnit.Case, async: true
  alias InvestmentTracker.CSVs.Parsers.Utils

  describe "parse_date/1" do
    test "parses a date string in the format 'dd/mm/yyyy' correctly" do
      assert Utils.parse_date("15/08/2032") == ~D[2032-08-15]
      assert Utils.parse_date("01/12/2021") == ~D[2021-12-01]
    end

    test "returns an error when given an invalid date string" do
      assert Utils.parse_date("15/13/2032") == :invalid_date
      assert Utils.parse_date("32/12/2021") == :invalid_date
    end
  end

  describe "extract_value/2" do
    test "extracts and returns an integer value from the input string using the given regex" do
      assert Utils.extract_value("R$ 1.234,56", ~r/R\$ ([\d\.,]+)/) == 123_456
      assert Utils.extract_value("Price: 3,250.00", ~r/Price: ([\d\.,]+)/) == 325_000
    end

    test "returns nil when the regex does not match the input string" do
      assert Utils.extract_value("R$ 1.234,56", ~r/Price: ([\d\.,]+)/) == nil
      assert Utils.extract_value("3,250.00", ~r/Price: ([\d\.,]+)/) == nil
    end
  end
end
