defmodule InvestmentTrackerWeb.CSVController do
  use InvestmentTrackerWeb, :controller

  alias InvestmentTracker.CSVs
  alias InvestmentTracker.CSVs.CSV
  alias InvestmentTracker.Wallet.Investment
  alias InvestmentTracker.Wallet.InvestmentHistory
  alias InvestmentTracker.Wallet.Operation

  def index(conn, _params) do
    csvs = CSVs.list_csvs()
    render(conn, :index, csvs: csvs)
  end

  def new(conn, _params) do
    changeset = CSVs.change_csv(%CSV{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"csv" => csv_params}) do
    case CSVs.import_csv(csv_params) do
      {:ok, data} ->
        {csv, records} = List.pop_at(data, 0)

        investments = extract_investments(records)

        investment_histories = extract_investment_histories(records)

        operations = extract_operations(records)

        conn
        |> put_flash(:info, "Csv created successfully.")
        |> render(:import,
          csv: csv,
          investments: investments,
          investment_histories: investment_histories,
          operations: operations
        )

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  defp extract_investments(records) do
    records
    |> Enum.map(fn record ->
      case record do
        {:ok, %Investment{} = investment} -> investment
        {:ok, {_, %Investment{} = investment, _}} -> investment
        _ -> nil
      end
    end)
    |> Enum.reject(fn investment -> is_nil(investment) end)
  end

  defp extract_investment_histories(records) do
    records
    |> Enum.map(fn record ->
      case record do
        {:ok, %Investment{investment_histories: histories}} -> histories
        {:ok, {_, %Investment{investment_histories: histories}, _}} -> histories
        _ -> nil
      end
    end)
    |> List.flatten()
    |> Enum.reject(fn history -> not is_struct(history, InvestmentHistory) end)
  end

  defp extract_operations(records) do
    records
    |> Enum.map(fn record ->
      case record do
        {:ok, {_, _, %Operation{} = operation}} -> operation
        _ -> nil
      end
    end)
    |> Enum.reject(fn operation -> is_nil(operation) end)
  end

  def show(conn, %{"id" => id}) do
    csv = CSVs.get_csv!(id)
    render(conn, :show, csv: csv)
  end

  def edit(conn, %{"id" => id}) do
    csv = CSVs.get_csv!(id)
    changeset = CSVs.change_csv(csv)
    render(conn, :edit, csv: csv, changeset: changeset)
  end

  def update(conn, %{"id" => id, "csv" => csv_params}) do
    csv = CSVs.get_csv!(id)

    case CSVs.update_csv(csv, csv_params) do
      {:ok, csv} ->
        conn
        |> put_flash(:info, "Csv updated successfully.")
        |> redirect(to: ~p"/csvs/#{csv}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, csv: csv, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    csv = CSVs.get_csv!(id)
    {:ok, _csv} = CSVs.delete_csv(csv)

    conn
    |> put_flash(:info, "Csv deleted successfully.")
    |> redirect(to: ~p"/csvs")
  end
end
