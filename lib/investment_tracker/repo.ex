defmodule InvestmentTracker.Repo do
  use Ecto.Repo,
    otp_app: :investment_tracker,
    adapter: Ecto.Adapters.Postgres
end
