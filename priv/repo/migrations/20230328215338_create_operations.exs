defmodule InvestmentTracker.Repo.Migrations.CreateOperations do
  use Ecto.Migration

  def change do
    create table(:operations, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :type, :string, null: false
      add :value, :integer, null: false
      add :investment_id, references(:investments, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:operations, [:investment_id])
  end
end
