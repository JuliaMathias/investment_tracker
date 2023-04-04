defmodule InvestmentTracker.Factory.Wallet do
  @moduledoc false
  alias InvestmentTracker.Wallet.Investment
  alias InvestmentTracker.Wallet.Operation

  defmacro __using__(_opts) do
    quote do
      def investment_factory do
        %Investment{
          current_value: 42,
          expiration_date: ~D[2023-03-27],
          initial_value: 42,
          name: "some name #{Enum.random(?a..?z)}",
          subtype: :cdb,
          type: :renda_fixa
        }
      end

      def operation_factory(attrs \\ %{}) do
        {investment, attrs} = Map.pop(attrs, :investment, build(:investment))

        %Operation{
          type: :deposit,
          value: 42,
          investment_id: investment.id
        }
        |> merge_attributes(attrs)
        |> evaluate_lazy_attributes()
      end
    end
  end
end
