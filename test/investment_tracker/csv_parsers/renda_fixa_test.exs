defmodule InvestmentTracker.CsvParsers.RendaFixaTest do
  @moduledoc false
  use ExUnit.Case, async: true

  alias InvestmentTracker.CsvParsers.RendaFixa

  test "parse_renda_fixa_csv/1" do
    file = "priv/static/reports/renda_fixa.csv"

    assert RendaFixa.parse_csv(file) == [
             %{
               current_value: 336_524,
               expiration_date: ~D[2023-08-11],
               initial_value: 311_729,
               name: "LCI MNO",
               subtype: :lci_lca,
               type: :renda_fixa
             },
             %{
               current_value: 329_238,
               expiration_date: ~D[2023-08-12],
               initial_value: 311_214,
               name: "LCA XYZ",
               subtype: :lci_lca,
               type: :renda_fixa
             },
             %{
               current_value: 573_425,
               expiration_date: ~D[2025-10-17],
               initial_value: 557_361,
               name: "DEBENTURE LIGHB6",
               subtype: :debentures,
               type: :renda_fixa
             },
             %{
               current_value: 203_456,
               expiration_date: ~D[2024-11-20],
               initial_value: 290_034,
               name: "CRI STRAIGHTS175E2",
               subtype: :cri_cra,
               type: :renda_fixa
             },
             %{
               current_value: 112_830,
               expiration_date: ~D[2029-07-17],
               initial_value: 107_825,
               name: "CRA GREEN130S2",
               subtype: :cri_cra,
               type: :renda_fixa
             },
             %{
               current_value: 1_231_149,
               expiration_date: ~D[2026-01-01],
               initial_value: 1_200_000,
               name: "CDB LIMIT PLUS",
               subtype: :cdb,
               type: :renda_fixa
             },
             %{
               current_value: 121_921,
               expiration_date: ~D[2024-01-01],
               initial_value: 105_000,
               name: "CDB YZC",
               subtype: :cdb,
               type: :renda_fixa
             }
           ]
  end
end
