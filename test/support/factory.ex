defmodule InvestmentTracker.Factory do
  use ExMachina.Ecto, repo: InvestmentTracker.Repo
  use InvestmentTracker.Factory.Wallet
end
