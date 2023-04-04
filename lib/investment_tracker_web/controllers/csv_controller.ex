defmodule InvestmentTrackerWeb.CSVController do
  use InvestmentTrackerWeb, :controller

  alias InvestmentTracker.CSVs
  alias InvestmentTracker.CSVs.CSV

  def index(conn, _params) do
    csvs = CSVs.list_csvs()
    render(conn, :index, csvs: csvs)
  end

  def new(conn, _params) do
    changeset = CSVs.change_csv(%CSV{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"csv" => csv_params}) do
    case CSVs.create_csv(csv_params) do
      {:ok, csv} ->
        conn
        |> put_flash(:info, "Csv created successfully.")
        |> redirect(to: ~p"/csvs/#{csv}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
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
