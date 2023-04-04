defmodule InvestmentTracker.Repo.Migrations.AddImportedFieldToCsvs do
  @moduledoc false
  use Ecto.Migration

  def change do
    alter table(:csvs) do
      add :imported?, :boolean, default: false
    end
  end
end
