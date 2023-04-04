defmodule InvestmentTracker.Repo.Migrations.CreateCsvs do
  @moduledoc false
  use Ecto.Migration

  def change do
    create table(:csvs, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :text
      add :content, :text
      add :type, :string

      timestamps()
    end
  end
end
