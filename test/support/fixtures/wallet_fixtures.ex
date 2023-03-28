defmodule InvestmentTracker.WalletFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `InvestmentTracker.Wallet` context.
  """

  @doc """
  Generate a investment.
  """
  def investment_fixture(attrs \\ %{}) do
    {:ok, investment} =
      attrs
      |> Enum.into(%{
        current_value: 42,
        expiration_date: ~D[2023-03-27],
        initial_value: 42,
        name: "some name",
        subtype: :cdb,
        type: :renda_fixa
      })
      |> InvestmentTracker.Wallet.create_investment()

    investment
  end
end
