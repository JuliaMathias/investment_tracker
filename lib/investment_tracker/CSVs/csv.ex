defmodule InvestmentTracker.CSVs.CSV do
  @moduledoc """
  An Ecto schema representing a CSV file
  containing investment data. It includes the content of the CSV, a title,
  an investment type, and a flag to track if the CSV has been imported.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @types ~w(renda_fixa fundos tesouro_direto renda_variavel)a

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "csvs" do
    field :content, :string
    field :title, :string
    field :type, Ecto.Enum, values: @types
    field :imported?, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(csv, attrs) do
    csv
    |> cast(attrs, [:title, :content, :type, :imported?])
    |> validate_required([:title, :content, :type, :imported?])
  end
end
