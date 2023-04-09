defmodule InvestmentTracker.Repo.Migrations.CreateInvestmentHistories do
  use Ecto.Migration

  def change do
    create table(:investment_histories, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :value, :integer, null: false

      add :investment_id, references(:investments, on_delete: :nothing, type: :binary_id),
        null: false

      timestamps()
    end

    create index(:investment_histories, [:investment_id])
  end
end
