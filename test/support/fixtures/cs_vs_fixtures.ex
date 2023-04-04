defmodule InvestmentTracker.CSVsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `InvestmentTracker.CSVs` context.
  """

  @doc """
  Generate a csv.
  """
  def csv_fixture(attrs \\ %{}) do
    {:ok, csv} =
      attrs
      |> Enum.into(%{
        content: "some content",
        title: "some title",
        type: :renda_fixa
      })
      |> InvestmentTracker.CSVs.create_csv()

    csv
  end
end
