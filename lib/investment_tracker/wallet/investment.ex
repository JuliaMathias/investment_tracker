defmodule InvestmentTracker.Wallet.Investment do
  @moduledoc """
  The Investment module represents an investment within the wallet.
  It defines the schema for the investments table and provides a changeset function
  for validation and casting of investment attributes.

  The module supports different investment types, including renda_fixa, fundos, tesouro_direto, and renda_variavel,
  and a variety of subtypes for each main type.
  """
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
    |> validate_subtype()
  end

  defp validate_subtype(changeset) do
    type = get_field(changeset, :type)
    subtype = get_field(changeset, :subtype)

    allowed_subtypes =
      case type do
        :renda_fixa -> @renda_fixa
        :fundos -> @fundos
        :tesouro_direto -> @tesouro_direto
        :renda_variavel -> @renda_variavel
        _ -> []
      end

    if subtype in allowed_subtypes do
      changeset
    else
      add_error(changeset, :subtype, "is invalid for the selected type")
    end
  end
end
