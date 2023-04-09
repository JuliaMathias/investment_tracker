defmodule InvestmentTracker.CSVs do
  @moduledoc """
  The CSVs context.
  """

  import Ecto.Query, warn: false

  alias InvestmentTracker.CSVs.CSV
  alias InvestmentTracker.CSVs.Parsers.Fundos
  alias InvestmentTracker.CSVs.Parsers.RendaFixa
  alias InvestmentTracker.CSVs.Parsers.RendaVariavel
  alias InvestmentTracker.CSVs.Parsers.TesouroDireto
  alias InvestmentTracker.Repo
  alias InvestmentTracker.Wallet
  alias InvestmentTracker.Wallet.Investment

  @doc """
  Returns the list of csvs.

  ## Examples

  iex> list_csvs()
  [%CSV{}, ...]

  """
  @spec list_csvs :: [CSV.t()]
  def list_csvs do
    Repo.all(CSV)
  end

  @doc """
  Gets a single csv.

  Raises `Ecto.NoResultsError` if the Csv does not exist.

  ## Examples

  iex> get_csv!(123)
  %CSV{}

  iex> get_csv!(456)
  ** (Ecto.NoResultsError)

  """
  @spec get_csv!(String.t()) :: CSV.t()
  def get_csv!(id), do: Repo.get!(CSV, id)

  @doc """
  Creates a csv.

  ## Examples

      iex> create_csv(%{field: value})
      {:ok, %CSV{}}

      iex> create_csv(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  @spec create_csv(map()) :: {:ok, CSV.t()} | {:error, Ecto.Changeset.t()}
  def create_csv(attrs \\ %{}) do
    %CSV{}
    |> CSV.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a csv.

  ## Examples

      iex> update_csv(csv, %{field: new_value})
      {:ok, %CSV{}}

      iex> update_csv(csv, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  @spec update_csv(CSV.t(), map()) :: {:ok, CSV.t()} | {:error, Ecto.Changeset.t()}
  def update_csv(%CSV{} = csv, attrs) do
    csv
    |> CSV.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a csv.

  ## Examples

      iex> delete_csv(csv)
      {:ok, %CSV{}}

      iex> delete_csv(csv)
      {:error, %Ecto.Changeset{}}

  """
  @spec delete_csv(CSV.t()) :: {:ok, CSV.t()} | {:error, Ecto.Changeset.t()}
  def delete_csv(%CSV{} = csv) do
    Repo.delete(csv)
  end

  @doc """
  Imports investment data from a CSV file by creating a CSV record and parsing its content.

  The function accepts a map of CSV attributes, creates a CSV record, and then parses the CSV content to
  extract investment information. It then saves the investments to the wallet using the Wallet.upsert_investment/1 function.

  Args:
    attrs: A map containing the CSV attributes.

  Returns:
    {:ok, [%Investment{}]} on success or {:error, %Ecto.Changeset{}} on failure.
  """
  @spec import_csv(map()) ::
          {:ok, [{:ok, Investment.t()} | {:ok, {:updated, Investment.t()}}]}
          | {:error, Ecto.Changeset.t()}
  def import_csv(attrs \\ %{}) do
    with {:ok, csv} <- create_csv(attrs),
         investment_maps <- parse_csv(csv),
         {:ok, result} <-
           Repo.transaction(fn ->
             Enum.map(investment_maps, fn map -> Wallet.upsert_investment(map) end)
           end),
         {:ok, csv} <- update_csv(csv, %{imported?: true}) do
      {:ok, [csv | result]}
    end
  end

  defp parse_csv(%{type: :fundos} = csv), do: Fundos.parse_csv(csv)
  defp parse_csv(%{type: :renda_fixa} = csv), do: RendaFixa.parse_csv(csv)
  defp parse_csv(%{type: :renda_variavel} = csv), do: RendaVariavel.parse_csv(csv)
  defp parse_csv(%{type: :tesouro_direto} = csv), do: TesouroDireto.parse_csv(csv)

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking csv changes.

  ## Examples

      iex> change_csv(csv)
      %Ecto.Changeset{data: %CSV{}}

  """
  @spec change_csv(map) :: Ecto.Changeset.t()
  def change_csv(%CSV{} = csv, attrs \\ %{}) do
    CSV.changeset(csv, attrs)
  end
end
