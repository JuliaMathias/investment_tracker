defmodule InvestmentTracker.CsvParsers.RendaFixa do
  @moduledoc """
  A parser for renda fixa investment CSV files, extracting relevant information
  and returning a list of maps.
  """
  alias InvestmentTracker.CsvParsers.Utils
  alias NimbleCSV.RFC4180, as: CSV

  @prefixes ~w(CDB CRA CRI DEBENTURE LCA LCI)

  @doc """
  Parses a CSV file and returns a list of maps with investment information.
  """
  @spec parse_csv(String.t()) :: list(map())
  def parse_csv(file) do
    filter_words = ~w(Emissão: Agência EXTRATO Nota Página Canais SAC Ouvidoria)

    chunk_fun = fn element, acc ->
      if String.starts_with?(List.first(element), @prefixes) do
        {:cont, [Enum.reject(element, fn x -> x == "" or x == "-" end) | acc], []}
      else
        {:cont, [Enum.reject(element, fn x -> x == "" or x == "-" end) | acc]}
      end
    end

    after_fun = fn
      [] -> {:cont, []}
      acc -> {:cont, Enum.reverse(acc), []}
    end

    file
    |> File.read!()
    |> CSV.parse_string()
    |> Enum.reject(fn x ->
      first = List.first(x)

      (first == "" and Enum.at(x, 1) == "") or String.starts_with?(first, filter_words)
    end)
    |> Enum.reverse()
    |> Enum.chunk_while([], chunk_fun, after_fun)
    |> Enum.map(&build_map(&1))
  end

  # Builds a map with investment data.
  defp build_map([[name], [_, current, initial] | rest]) do
    date_string = rest |> List.last() |> Enum.at(2)

    initial_value_regex = ~r/Valor Aplicado Total: R\$ ([\d\.]+,[\d]+)/
    current_value_regex = ~r/Valor Líquido Total: R\$ ([\d\.]+,[\d]+)/

    %{
      current_value: Utils.extract_value(current, current_value_regex),
      expiration_date: Utils.parse_date(date_string),
      initial_value: Utils.extract_value(initial, initial_value_regex),
      name: name,
      subtype: parse_subtype(name),
      type: :renda_fixa
    }
  end

  # Parses the subtype of the investment from its name.
  defp parse_subtype(name) do
    cond do
      String.starts_with?(name, "CDB") ->
        :cdb

      String.starts_with?(name, "CRA") or String.starts_with?(name, "CRI") ->
        :cri_cra

      String.starts_with?(name, "DEBENTURE") ->
        :debentures

      String.starts_with?(name, "LCA") or String.starts_with?(name, "LCI") ->
        :lci_lca

      true ->
        nil
    end
  end
end
