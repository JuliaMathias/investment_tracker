defmodule InvestmentTracker.CSVs.Parsers.TesouroDireto do
  @moduledoc """
  A CSV parser for the Tesouro Direto investment information.
  """

  alias InvestmentTracker.CSVs.CSV
  alias InvestmentTracker.CSVs.Parsers.Utils
  alias NimbleCSV.RFC4180, as: NimbleCSV

  @doc """
  Parses a CSV struct containing Tesouro Direto investment data.

  Returns a list of maps with the investment data.
  """
  @spec parse_csv(CSV.t()) :: list(map())
  def parse_csv(%{content: csv}) do
    csv
    |> NimbleCSV.parse_string()
    |> Enum.reject(fn x -> List.first(x) == "" end)
    |> Enum.map(&build_map/1)
  end

  defp build_map([name, _, _, subtype, date, _, _, _, _, initial, _, current, _]) do
    regex = ~r/R\$([\d\.]+,[\d]+)/

    %{
      current_value: Utils.extract_value(current, regex),
      expiration_date: Utils.parse_date(date),
      initial_value: Utils.extract_value(initial, regex),
      name: name,
      subtype: parse_subtype(subtype),
      type: :tesouro_direto
    }
  end

  # Parses the subtype of the fund based on its name.
  defp parse_subtype(subtype) do
    cond do
      String.starts_with?(subtype, "SELIC") -> :selic
      String.starts_with?(subtype, "Prefixado") -> :prefixado
      String.starts_with?(subtype, "IPCA") -> :ipca
    end
  end
end
