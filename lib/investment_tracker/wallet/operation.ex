defmodule InvestmentTracker.Wallet.Operation do
  use Ecto.Schema
  import Ecto.Changeset

  @types ~w(deposit withdraw update)a

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "operations" do
    field :type, Ecto.Enum, values: @types
    field :value, :integer
    field :investment_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(operation, attrs) do
    operation
    |> cast(attrs, [:type, :value])
    |> validate_required([:type, :value])
  end
end
