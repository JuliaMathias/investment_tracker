defmodule InvestmentTracker.CsvParsers.RendaVariavelTest do
  @moduledoc false
  use ExUnit.Case, async: true
  doctest InvestmentTracker.CsvParsers.RendaVariavel
  alias InvestmentTracker.CsvParsers.RendaVariavel

  test "parse_csv/1" do
    file = "priv/static/reports/renda_variavel.csv"

    assert RendaVariavel.parse_csv(file) == [
             %{
               current_value: 60_450,
               initial_value: 63_300,
               name: "ANON01",
               subtype: :fiis,
               type: :renda_variavel
             },
             %{
               current_value: 44_000,
               initial_value: 52_000,
               name: "ANON02",
               subtype: :fiis,
               type: :renda_variavel
             },
             %{
               current_value: 56_000,
               initial_value: 62_400,
               name: "ANON03",
               subtype: :fiis,
               type: :renda_variavel
             },
             %{
               current_value: 49_350,
               initial_value: 56_700,
               name: "ANON04",
               subtype: :fiis,
               type: :renda_variavel
             },
             %{
               current_value: 58_800,
               initial_value: 59_500,
               name: "ANON05",
               subtype: :fiis,
               type: :renda_variavel
             },
             %{
               current_value: 51_000,
               initial_value: 60_600,
               name: "ANON06",
               subtype: :fiis,
               type: :renda_variavel
             }
           ]
  end
end
