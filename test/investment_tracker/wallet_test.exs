defmodule InvestmentTracker.WalletTest do
  use InvestmentTracker.DataCase

  alias InvestmentTracker.Wallet

  describe "investments" do
    alias InvestmentTracker.Wallet.Investment

    import InvestmentTracker.WalletFixtures

    @invalid_attrs %{
      current_value: nil,
      expiration_date: nil,
      initial_value: nil,
      name: nil,
      subtype: nil,
      type: nil
    }

    test "list_investments/0 returns all investments" do
      investment = investment_fixture()
      assert Wallet.list_investments() == [investment]
    end

    test "get_investment!/1 returns the investment with given id" do
      investment = investment_fixture()
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

    test "update_investment/2 with valid data updates the investment" do
      investment = investment_fixture()

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

    test "update_investment/2 with invalid data returns error changeset" do
      investment = investment_fixture()
      assert {:error, %Ecto.Changeset{}} = Wallet.update_investment(investment, @invalid_attrs)
      assert investment == Wallet.get_investment!(investment.id)
    end

    test "delete_investment/1 deletes the investment" do
      investment = investment_fixture()
      assert {:ok, %Investment{}} = Wallet.delete_investment(investment)
      assert_raise Ecto.NoResultsError, fn -> Wallet.get_investment!(investment.id) end
    end

    test "change_investment/1 returns a investment changeset" do
      investment = investment_fixture()
      assert %Ecto.Changeset{} = Wallet.change_investment(investment)
    end
  end

  describe "operations" do
    alias InvestmentTracker.Wallet.Operation

    import InvestmentTracker.WalletFixtures

    @invalid_attrs %{type: nil, value: nil}

    test "list_operations/0 returns all operations" do
      operation = operation_fixture()
      assert Wallet.list_operations() == [operation]
    end

    test "get_operation!/1 returns the operation with given id" do
      operation = operation_fixture()
      assert Wallet.get_operation!(operation.id) == operation
    end

    test "create_operation/1 with valid data creates a operation" do
      valid_attrs = %{type: :deposit, value: 42}

      assert {:ok, %Operation{} = operation} = Wallet.create_operation(valid_attrs)
      assert operation.type == :deposit
      assert operation.value == 42
    end

    test "create_operation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Wallet.create_operation(@invalid_attrs)
    end

    test "update_operation/2 with valid data updates the operation" do
      operation = operation_fixture()
      update_attrs = %{type: :withdraw, value: 43}

      assert {:ok, %Operation{} = operation} = Wallet.update_operation(operation, update_attrs)
      assert operation.type == :withdraw
      assert operation.value == 43
    end

    test "update_operation/2 with invalid data returns error changeset" do
      operation = operation_fixture()
      assert {:error, %Ecto.Changeset{}} = Wallet.update_operation(operation, @invalid_attrs)
      assert operation == Wallet.get_operation!(operation.id)
    end

    test "delete_operation/1 deletes the operation" do
      operation = operation_fixture()
      assert {:ok, %Operation{}} = Wallet.delete_operation(operation)
      assert_raise Ecto.NoResultsError, fn -> Wallet.get_operation!(operation.id) end
    end

    test "change_operation/1 returns a operation changeset" do
      operation = operation_fixture()
      assert %Ecto.Changeset{} = Wallet.change_operation(operation)
    end
  end
end
