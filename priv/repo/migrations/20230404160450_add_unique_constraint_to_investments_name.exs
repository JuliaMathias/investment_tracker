defmodule InvestmentTracker.Repo.Migrations.AddUniqueConstraintToInvestmentsName do
  @moduledoc false
  use Ecto.Migration

  def change do
    create unique_index(:investments, [:name])
  end
end
