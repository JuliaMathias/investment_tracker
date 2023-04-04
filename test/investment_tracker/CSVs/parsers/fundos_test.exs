defmodule InvestmentTracker.CSVs.Parsers.FundosTest do
  @moduledoc false
  use InvestmentTracker.DataCase, async: true

  import InvestmentTracker.Factory

  alias InvestmentTracker.CSVs.Parsers.Fundos

  test "parse_csv/1" do
    csv = insert(:fundos_csv)

    assert Fundos.parse_csv(csv) == [
             %{
               current_value: 689_292,
               initial_value: 646_965,
               name: "ANON ACCESS ABC CAPITAL FIM",
               subtype: :multimercado,
               type: :fundos
             },
             %{
               current_value: 500_796,
               initial_value: 500_000,
               name: "DAICHI KARAZUNO FIC FIM CP",
               subtype: :multimercado,
               type: :fundos
             },
             %{
               current_value: 202_163,
               initial_value: 200_000,
               name: "ANON ACCESS TRIGONOMETRY BS FIC FIM",
               subtype: :multimercado,
               type: :fundos
             },
             %{
               current_value: 522_196,
               initial_value: 538_799,
               name: "CALIFORNIAN WHATEVER US INDEX 500 FIM",
               subtype: :multimercado,
               type: :fundos
             },
             %{
               current_value: 5705,
               initial_value: 5702,
               name: "ANON RENDA AMAZING FIRF LP",
               subtype: :renda_fixa,
               type: :fundos
             },
             %{
               current_value: 518_714,
               initial_value: 494_986,
               name: "CUTE HAMTARO STH FIC FIM",
               subtype: :multimercado,
               type: :fundos
             },
             %{
               current_value: 151_657,
               initial_value: 150_000,
               name: "ANON RENDA FIRF CP",
               subtype: :renda_fixa,
               type: :fundos
             },
             %{
               current_value: 1_003_332,
               initial_value: 1_000_000,
               name: "ANON RARE FIRF CP",
               subtype: :renda_fixa,
               type: :fundos
             },
             %{
               current_value: 68_006,
               initial_value: 69_990,
               name: "ANON SELECTION MULTIESTRATEGIA FIC FIM",
               subtype: :multimercado,
               type: :fundos
             },
             %{
               current_value: 3_613_420,
               initial_value: 3_500_000,
               name: "ALPHA OMEGA GLOBAL FIC FIM",
               subtype: :multimercado,
               type: :fundos
             }
           ]
  end
end
