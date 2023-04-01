defmodule InvestmentTracker.CsvParsers.Utils do
  @moduledoc """
  Utility functions for parsing dates and extracting values from strings in CSV parsers.
  """

  @spec parse_date(String.t()) :: Date.t() | :invalid_date
  @doc """
  Parses a date string in the format "dd/mm/yyyy" and returns a Date struct.

  ## Examples

      iex> InvestmentTracker.CsvParsers.Utils.parse_date("15/08/2032")
      ~D[2032-08-15]
  """
  def parse_date(date_string) do
    [day, month, year] = String.split(date_string, "/")

    [year, month, day]
    |> Enum.join("-")
    |> Date.from_iso8601()
    |> elem(1)
  end

  @spec extract_value(String.t(), Regex.t()) :: integer() | nil
  @doc """
  Extracts a value from the input string using the given regex and converts it to an integer.

  Returns the extracted value as an integer, or nil if no match is found.

  ## Examples

      iex> InvestmentTracker.CsvParsers.Utils.extract_value("R$ 1.234,56", ~r/R\$ ([\d\.,]+)/)
      123456
  """
  def extract_value(input_string, regex) do
    case Regex.run(regex, input_string) do
      [_, value] ->
        value
        |> String.replace(~r/[\.,]/, "")
        |> String.to_integer()

      _ ->
        nil
    end
  end
end
