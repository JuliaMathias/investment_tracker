defmodule InvestmentTracker.Wallet.InvestmentHistory do
  @moduledoc """
  This schema tracks the history of an investment's value.
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias InvestmentTracker.Wallet.Investment

  @typedoc """
  Type representing the InvestmentHistory struct.
  """
  @type t :: %__MODULE__{
          id: binary(),
          value: integer(),
          investment_id: binary(),
          investment: Investment.t()
        }

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "investment_histories" do
    field :value, :integer

    belongs_to :investment, Investment

    timestamps()
  end

  @doc false
  def changeset(investment_history, attrs) do
    investment_history
    |> cast(attrs, [:value, :investment_id])
    |> validate_required([:value, :investment_id])
    |> assoc_constraint(:investment)
  end
end
