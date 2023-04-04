defmodule InvestmentTracker.Factory do
  @moduledoc """
  Factories to help us with tests.
  """
  use ExMachina.Ecto, repo: InvestmentTracker.Repo
  use InvestmentTracker.Factory.CSVs
  use InvestmentTracker.Factory.Wallet
end
