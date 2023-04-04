defmodule InvestmentTracker.WalletTest do
  @moduledoc false
  use InvestmentTracker.DataCase, async: true

  import InvestmentTracker.Factory

  alias InvestmentTracker.Wallet
  alias InvestmentTracker.Wallet.Investment
  alias InvestmentTracker.Wallet.Operation

  setup do
    {:ok, investment: insert(:investment)}
  end

  describe "investments" do
    @invalid_attrs %{
      current_value: nil,
      expiration_date: nil,
      initial_value: nil,
      name: nil,
      subtype: nil,
      type: nil
    }

    test "list_investments/0 returns all investments", %{investment: investment} do
      assert Wallet.list_investments() == [investment]
    end

    test "get_investment!/1 returns the investment with given id", %{investment: investment} do
      assert Wallet.get_investment!(investment.id) == investment
    end

    test "create_investment/1 with valid data creates a investment" do
      valid_attrs = %{
        current_value: 42,
        expiration_date: ~D[2023-03-27],
        initial_value: 42,
        name: "some name",
        subtype: :multimercado,
        type: :fundos
      }

      assert {:ok, %Investment{} = investment} = Wallet.create_investment(valid_attrs)
      assert investment.current_value == 42
      assert investment.expiration_date == ~D[2023-03-27]
      assert investment.initial_value == 42
      assert investment.name == "some name"
      assert investment.subtype == :multimercado
      assert investment.type == :fundos
    end

    test "create_investment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Wallet.create_investment(@invalid_attrs)
    end

    test "create_investment/1 with invalid subtype returns error changeset" do
      invalid_attrs = %{
        current_value: 42,
        expiration_date: ~D[2023-03-27],
        initial_value: 42,
        name: "some name",
        # Invalid subtype for :fundos type
        subtype: :cdb,
        type: :fundos
      }

      {:error, changeset} = Wallet.create_investment(invalid_attrs)
      assert %{subtype: ["is invalid for the selected type"]} = errors_on(changeset)
    end

    test "update_investment/2 with invalid subtype returns error changeset", %{
      investment: investment
    } do
      update_attrs = %{
        current_value: 43,
        expiration_date: ~D[2023-03-28],
        initial_value: 43,
        name: "some updated name",
        # Invalid subtype for :fundos type
        subtype: :cdb,
        type: :fundos
      }

      {:error, changeset} = Wallet.update_investment(investment, update_attrs)
      assert %{subtype: ["is invalid for the selected type"]} = errors_on(changeset)
    end

    test "update_investment/2 with valid data updates the investment", %{investment: investment} do
      update_attrs = %{
        current_value: 43,
        expiration_date: ~D[2023-03-28],
        initial_value: 43,
        name: "some updated name",
        subtype: :lci_lca,
        type: :renda_fixa
      }

      assert {:ok, %Investment{} = investment} =
               Wallet.update_investment(investment, update_attrs)

      assert investment.current_value == 43
      assert investment.expiration_date == ~D[2023-03-28]
      assert investment.initial_value == 43
      assert investment.name == "some updated name"
      assert investment.subtype == :lci_lca
      assert investment.type == :renda_fixa
    end

    test "update_investment/2 with invalid data returns error changeset", %{
      investment: investment
    } do
      assert {:error, %Ecto.Changeset{}} = Wallet.update_investment(investment, @invalid_attrs)
      assert investment == Wallet.get_investment!(investment.id)
    end

    test "delete_investment/1 deletes the investment", %{investment: investment} do
      assert {:ok, %Investment{}} = Wallet.delete_investment(investment)
      assert_raise Ecto.NoResultsError, fn -> Wallet.get_investment!(investment.id) end
    end

    test "change_investment/1 returns a investment changeset", %{investment: investment} do
      assert %Ecto.Changeset{} = Wallet.change_investment(investment)
    end
  end

  describe "operations" do
    @invalid_attrs %{type: nil, value: nil}

    test "list_operations/0 returns all operations", %{investment: investment} do
      operation = insert(:operation, investment: investment)
      assert Wallet.list_operations() == [operation]
    end

    test "get_operation!/1 returns the operation with given id", %{investment: investment} do
      operation = insert(:operation, investment: investment)
      assert Wallet.get_operation!(operation.id) == operation
    end

    test "create_operation/1 with valid data creates a operation", %{investment: investment} do
      valid_attrs = %{type: :deposit, value: 42, investment_id: investment.id}

      assert {:ok, %Operation{} = operation} = Wallet.create_operation(valid_attrs)
      assert operation.type == :deposit
      assert operation.value == 42
    end

    test "create_operation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Wallet.create_operation(@invalid_attrs)
    end

    test "update_operation/2 with valid data updates the operation", %{investment: investment} do
      operation = insert(:operation, investment: investment)
      update_attrs = %{type: :withdraw, value: 43}

      assert {:ok, %Operation{} = operation} = Wallet.update_operation(operation, update_attrs)
      assert operation.type == :withdraw
      assert operation.value == 43
    end

    test "update_operation/2 with invalid data returns error changeset", %{investment: investment} do
      operation = insert(:operation, investment: investment)
      assert {:error, %Ecto.Changeset{}} = Wallet.update_operation(operation, @invalid_attrs)
      assert operation == Wallet.get_operation!(operation.id)
    end

    test "delete_operation/1 deletes the operation", %{investment: investment} do
      operation = insert(:operation, investment: investment)
      assert {:ok, %Operation{}} = Wallet.delete_operation(operation)
      assert_raise Ecto.NoResultsError, fn -> Wallet.get_operation!(operation.id) end
    end

    test "change_operation/1 returns a operation changeset", %{investment: investment} do
      operation = insert(:operation, investment: investment)
      assert %Ecto.Changeset{} = Wallet.change_operation(operation)
    end
  end
end
