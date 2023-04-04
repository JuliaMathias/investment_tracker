defmodule InvestmentTracker.CSVs.Parsers.TesouroDiretoTest do
  @moduledoc false
  use InvestmentTracker.DataCase, async: true

  import InvestmentTracker.Factory

  alias InvestmentTracker.CSVs.Parsers.TesouroDireto

  test "parse_csv/1" do
    csv = insert(:tesouro_direto_csv)

    assert TesouroDireto.parse_csv(csv) == [
             %{
               current_value: 2_676_504,
               initial_value: 2_443_023,
               name: "Tesouro Selic 2025",
               subtype: :selic,
               type: :tesouro_direto,
               expiration_date: ~D[2025-03-01]
             },
             %{
               current_value: 3_490_543,
               initial_value: 3_123_456,
               name: "Tesouro Prefixado 2029",
               subtype: :prefixado,
               type: :tesouro_direto,
               expiration_date: ~D[2029-12-01]
             },
             %{
               current_value: 6_123_456,
               initial_value: 5_543_212,
               name: "Tesouro IPCA+ Com Juros Semestrais 2032",
               subtype: :ipca,
               type: :tesouro_direto,
               expiration_date: ~D[2032-08-15]
             }
           ]
  end
end
