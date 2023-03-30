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

  @doc """
  Generate a operation.
  """
  def operation_fixture(attrs \\ %{}) do
    {:ok, operation} =
      attrs
      |> Enum.into(%{
        type: :deposit,
        value: 42
      })
      |> InvestmentTracker.Wallet.create_operation()

    operation
  end
end
