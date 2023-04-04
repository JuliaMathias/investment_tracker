defmodule InvestmentTracker.CSVs.Parsers.Fundos do
  @moduledoc """
  A module to parse CSV files for Fundos (Investment Funds) and extract relevant
  information.
  """

  alias InvestmentTracker.CSVs.CSV
  alias InvestmentTracker.CSVs.Parsers.Utils
  alias NimbleCSV.RFC4180, as: NimbleCSV

  @doc """
  Parses the given CSV struct and returns a list of maps containing relevant
  information about the fundos.
  """
  @spec parse_csv(CSV.t()) :: list(map())
  def parse_csv(%{content: csv}) do
    csv
    |> NimbleCSV.parse_string()
    |> Enum.reject(fn x ->
      first = List.first(x)
      Enum.at(x, 3) == "" or String.starts_with?(first, ["TABLE", "Data"])
    end)
    |> Enum.map(fn list -> Enum.reject(list, fn element -> element == "" end) end)
    |> Enum.chunk_every(2)
    |> Enum.map(&build_map/1)
  end

  # Builds a map containing the relevant information about a fundo
  defp build_map([name_list, [_, _, _, initial, _, _, _, current]]) do
    name = Enum.join(name_list, " ")

    regex = ~r/R \$ ([\d\.]+,[\d]+)/

    %{
      current_value: Utils.extract_value(current, regex),
      initial_value: Utils.extract_value(initial, regex),
      name: name,
      subtype: parse_subtype(name),
      type: :fundos
    }
  end

  # Parses the subtype of the fundo based on its name.
  defp parse_subtype(name) do
    cond do
      String.starts_with?(name, "INTER C") -> :renda_fixa
      String.starts_with?(name, "ANON R") -> :renda_fixa
      true -> :multimercado
    end
  end
end
