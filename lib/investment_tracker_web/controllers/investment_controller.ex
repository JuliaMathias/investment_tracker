defmodule InvestmentTrackerWeb.InvestmentController do
  use InvestmentTrackerWeb, :controller

  alias InvestmentTracker.Wallet
  alias InvestmentTracker.Wallet.Investment

  def index(conn, _params) do
    investments = Wallet.list_investments()
    render(conn, :index, investments: investments)
  end

  def new(conn, _params) do
    changeset = Wallet.change_investment(%Investment{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"investment" => investment_params}) do
    case Wallet.create_investment(investment_params) do
      {:ok, investment} ->
        conn
        |> put_flash(:info, "Investment created successfully.")
        |> redirect(to: ~p"/investments/#{investment}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    investment = Wallet.get_investment!(id)
    render(conn, :show, investment: investment)
  end

  def edit(conn, %{"id" => id}) do
    investment = Wallet.get_investment!(id)
    changeset = Wallet.change_investment(investment)
    render(conn, :edit, investment: investment, changeset: changeset)
  end

  def update(conn, %{"id" => id, "investment" => investment_params}) do
    investment = Wallet.get_investment!(id)

    case Wallet.update_investment(investment, investment_params) do
      {:ok, investment} ->
        conn
        |> put_flash(:info, "Investment updated successfully.")
        |> redirect(to: ~p"/investments/#{investment}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, investment: investment, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    investment = Wallet.get_investment!(id)
    {:ok, _investment} = Wallet.delete_investment(investment)

    conn
    |> put_flash(:info, "Investment deleted successfully.")
    |> redirect(to: ~p"/investments")
  end
end
