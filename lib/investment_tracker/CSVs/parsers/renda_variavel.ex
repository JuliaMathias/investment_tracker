defmodule InvestmentTracker.CSVs.Parsers.RendaVariavel do
  @moduledoc """
  A CSV parser for Renda Variável investment information.
  """

  alias InvestmentTracker.CSVs.CSV
  alias InvestmentTracker.CSVs.Parsers.Utils
  alias NimbleCSV.RFC4180, as: NimbleCSV

  @doc """
  Parses a CSV struct containing Renda Variável investment data.

  Returns a list of maps with the investment data.
  """
  @spec parse_csv(CSV.t()) :: list(map())
  def parse_csv(%{content: csv}) do
    csv
    |> NimbleCSV.parse_string()
    |> Enum.reject(fn x ->
      first = List.first(x)
      Enum.at(x, 3) == "" or String.starts_with?(first, ["TABLE", "Quantidade"])
    end)
    |> Enum.chunk_every(2)
    |> Enum.map(&build_map/1)
  end

  defp build_map([[_, _, _, name, _, _, _], [_, _, initial, _, current, _, _]]) do
    regex = ~r/R \$ ([\d\.]+,[\d]+)/

    %{
      current_value: Utils.extract_value(current, regex),
      initial_value: Utils.extract_value(initial, regex),
      name: name,
      subtype: :fiis,
      type: :renda_variavel
    }
  end
end
