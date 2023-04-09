defmodule InvestmentTracker.WalletTest do
  @moduledoc false
  use InvestmentTracker.DataCase, async: true

  import InvestmentTracker.Factory

  alias InvestmentTracker.Repo
  alias InvestmentTracker.Wallet
  alias InvestmentTracker.Wallet.Investment
  alias InvestmentTracker.Wallet.InvestmentHistory
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

    test "create_investment/1 with valid data creates a investment and investment history" do
      valid_attrs = %{
        current_value: 42,
        expiration_date: ~D[2023-03-27],
        initial_value: 42,
        name: "some name",
        subtype: :multimercado,
        type: :fundos
      }

      assert {:ok, %Investment{} = investment} = Wallet.create_investment(valid_attrs)
      investment_id = investment.id
      assert investment.current_value == 42
      assert investment.expiration_date == ~D[2023-03-27]
      assert investment.initial_value == 42
      assert investment.name == "some name"
      assert investment.subtype == :multimercado
      assert investment.type == :fundos

      assert %InvestmentHistory{investment_id: ^investment_id, value: 42} =
               Repo.get_by(InvestmentHistory, investment_id: investment_id)
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

    test "update_investment/2 with valid data updates the investment and creates investment history",
         %{investment: investment} do
      update_attrs = %{
        current_value: 103,
        expiration_date: ~D[2023-03-28],
        name: "some updated name",
        subtype: :lci_lca,
        type: :renda_fixa
      }

      refute investment.current_value == 103

      assert {:ok, %Investment{} = investment} =
               Wallet.update_investment(investment, update_attrs)

      investment_id = investment.id
      assert investment.current_value == 103
      assert investment.expiration_date == ~D[2023-03-28]
      assert investment.name == "some updated name"
      assert investment.subtype == :lci_lca
      assert investment.type == :renda_fixa

      assert %InvestmentHistory{investment_id: ^investment_id, value: 103} =
               Repo.get_by(InvestmentHistory, investment_id: investment_id)
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

  describe "upsert_investment/1" do
    test "creates a new investment if the name does not exist" do
      attrs = %{
        name: "New Investment",
        type: :renda_fixa,
        subtype: :cdb,
        initial_value: 1000,
        current_value: 1000
      }

      {:ok, investment} = Wallet.upsert_investment(attrs)

      assert %Investment{} = investment
      assert investment.name == "New Investment"
    end

    test "updates an existing investment and creates an operation if the current_value is different" do
      investment = insert(:investment, name: "Existing Investment", current_value: 1000)

      attrs = %{
        name: "Existing Investment",
        current_value: 2000
      }

      {:ok, {:updated, updated_investment, operation}} = Wallet.upsert_investment(attrs)

      assert %Investment{} = updated_investment
      assert updated_investment.name == "Existing Investment"
      assert updated_investment.current_value == 2000

      assert %Operation{} = operation
      assert operation.type == :update
      assert operation.value == 1000
      assert operation.investment_id == investment.id
    end

    test "does not update the investment or create an operation if the current_value is the same" do
      _investment = insert(:investment, name: "Unchanged Investment", current_value: 1000)

      attrs = %{
        name: "Unchanged Investment",
        current_value: 1000
      }

      {:ok, unchanged_investment} = Wallet.upsert_investment(attrs)

      assert %Investment{} = unchanged_investment
      assert unchanged_investment.name == "Unchanged Investment"
      assert unchanged_investment.current_value == 1000

      refute_received({InvestmentTracker.Repo, :insert, [%Operation{}]})
    end
  end

  describe "investment_histories" do
    @invalid_attrs %{value: nil}

    test "list_histories_for_investment/1 returns all investment_histories for the given investment" do
      valid_attrs = %{
        current_value: 42,
        expiration_date: ~D[2023-03-27],
        initial_value: 42,
        name: "some name",
        subtype: :multimercado,
        type: :fundos
      }

      {:ok, %{id: investment_id} = investment} = Wallet.create_investment(valid_attrs)

      update_attrs = %{
        current_value: 103,
        expiration_date: ~D[2023-03-28],
        name: "some updated name",
        subtype: :lci_lca,
        type: :renda_fixa
      }

      Wallet.update_investment(investment, update_attrs)

      assert [
               %InvestmentTracker.Wallet.InvestmentHistory{
                 value: 42,
                 investment_id: ^investment_id
               },
               %InvestmentTracker.Wallet.InvestmentHistory{
                 value: 103,
                 investment_id: ^investment_id
               }
             ] = Wallet.list_histories_for_investment(investment_id)
    end

    test "create_investment_history/1 with valid data creates a investment_history" do
      investment = insert(:investment)
      valid_attrs = %{value: 42, investment_id: investment.id}

      assert {:ok, %InvestmentHistory{} = investment_history} =
               Wallet.create_investment_history(valid_attrs)

      assert investment_history.value == 42
    end

    test "create_investment_history/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Wallet.create_investment_history(@invalid_attrs)
    end

    test "delete_investment_history/1 deletes the investment_history" do
      investment = insert(:investment)
      investment_history = insert(:investment_history, investment: investment)
      assert {:ok, %InvestmentHistory{}} = Wallet.delete_investment_history(investment_history)

      assert_raise Ecto.NoResultsError, fn ->
        Repo.get!(InvestmentHistory, investment_history.id)
      end
    end
  end
end
