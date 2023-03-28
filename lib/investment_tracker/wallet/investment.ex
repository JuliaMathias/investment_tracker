defmodule InvestmentTracker.Wallet.Investment do
  use Ecto.Schema
  import Ecto.Changeset

  @types ~w(renda_fixa fundos tesouro_direto renda_variavel)a
  @renda_fixa ~w(cdb lci_lca cri_cra debentures)a
  @fundos ~w(renda_fixa multimercado)a
  @tesouro_direto ~w(selic prefixado ipca)a
  @renda_variavel ~w(fiis)a
  @subtypes @renda_fixa ++ @fundos ++ @tesouro_direto ++ @renda_variavel

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "investments" do
    field :current_value, :integer
    field :expiration_date, :date
    field :initial_value, :integer
    field :name, :string
    field :subtype, Ecto.Enum, values: @subtypes
    field :type, Ecto.Enum, values: @types

    timestamps()
  end

  @doc false
  def changeset(investment, attrs) do
    investment
    |> cast(attrs, [:name, :type, :subtype, :initial_value, :current_value, :expiration_date])
    |> validate_required([:name, :type, :initial_value, :current_value])
  end
end
