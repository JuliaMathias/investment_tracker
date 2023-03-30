defmodule InvestmentTrackerWeb.OperationController do
  use InvestmentTrackerWeb, :controller

  alias InvestmentTracker.Wallet
  alias InvestmentTracker.Wallet.Operation

  def index(conn, _params) do
    operations = Wallet.list_operations()
    render(conn, :index, operations: operations)
  end

  def new(conn, _params) do
    changeset = Wallet.change_operation(%Operation{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"operation" => operation_params}) do
    case Wallet.create_operation(operation_params) do
      {:ok, operation} ->
        conn
        |> put_flash(:info, "Operation created successfully.")
        |> redirect(to: ~p"/operations/#{operation}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    operation = Wallet.get_operation!(id)
    render(conn, :show, operation: operation)
  end

  def edit(conn, %{"id" => id}) do
    operation = Wallet.get_operation!(id)
    changeset = Wallet.change_operation(operation)
    render(conn, :edit, operation: operation, changeset: changeset)
  end

  def update(conn, %{"id" => id, "operation" => operation_params}) do
    operation = Wallet.get_operation!(id)

    case Wallet.update_operation(operation, operation_params) do
      {:ok, operation} ->
        conn
        |> put_flash(:info, "Operation updated successfully.")
        |> redirect(to: ~p"/operations/#{operation}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, operation: operation, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    operation = Wallet.get_operation!(id)
    {:ok, _operation} = Wallet.delete_operation(operation)

    conn
    |> put_flash(:info, "Operation deleted successfully.")
    |> redirect(to: ~p"/operations")
  end
end
