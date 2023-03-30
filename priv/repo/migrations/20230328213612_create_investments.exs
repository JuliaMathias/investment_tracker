defmodule InvestmentTracker.Repo.Migrations.CreateInvestments do
  use Ecto.Migration

  def change do
    create table(:investments, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string, null: false
      add :type, :string, null: false
      add :subtype, :string
      add :initial_value, :integer, null: false
      add :current_value, :integer, null: false
      add :expiration_date, :date

      timestamps()
    end
  end
end
