defmodule InvestmentTracker.Wallet.Operation do
  @moduledoc """
  This module defines the schema and changeset for `Operation` records.

  An `Operation` record represents an action performed on an investment,
  such as deposit, withdraw, or update. Each operation has a `type`, `value`,
  and `investment_id` associated with it.
  """
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
    |> cast(attrs, [:type, :value, :investment_id])
    |> validate_required([:type, :value, :investment_id])
  end
end
