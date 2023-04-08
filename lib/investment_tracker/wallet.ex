defmodule InvestmentTracker.Wallet do
  @moduledoc """
  The Wallet context.
  """

  import Ecto.Query, warn: false

  alias InvestmentTracker.Repo
  alias InvestmentTracker.Wallet.Investment
  alias InvestmentTracker.Wallet.InvestmentHistory
  alias InvestmentTracker.Wallet.Operation

  @doc """
  Returns the list of investments.

  ## Examples

      iex> list_investments()
      [%Investment{}, ...]

  """
  @spec list_investments() :: list(Investment.t())
  def list_investments do
    Repo.all(Investment)
  end

  @doc """
  Gets a single investment.

  Raises `Ecto.NoResultsError` if the Investment does not exist.

  ## Examples

      iex> get_investment!(123)
      %Investment{}

      iex> get_investment!(456)
      ** (Ecto.NoResultsError)

  """
  @spec get_investment!(integer()) :: Investment.t()
  def get_investment!(id), do: Repo.get!(Investment, id)

  @doc """
  Creates a investment.

  ## Examples

      iex> create_investment(%{field: value})
      {:ok, %Investment{}}

      iex> create_investment(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  @spec create_investment(map()) :: {:ok, Investment.t()} | {:error, Ecto.Changeset.t()}
  def create_investment(attrs \\ %{}) do
    with %{valid?: true} = changeset <- Investment.changeset(%Investment{}, attrs),
         {:ok, investment} <- Repo.insert(changeset),
         {:ok, _investment_history} <-
           create_investment_history(%{
             investment_id: investment.id,
             value: investment.current_value
           }) do
      {:ok, investment}
    else
      {:error, changeset} -> {:error, changeset}
      changeset -> {:error, changeset}
    end
  end

  @doc """
  Updates a investment.

  ## Examples

      iex> update_investment(investment, %{field: new_value})
      {:ok, %Investment{}}

      iex> update_investment(investment, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  @spec update_investment(Investment.t(), map()) ::
          {:ok, Investment.t()} | {:error, Ecto.Changeset.t()}
  def update_investment(%Investment{} = investment, attrs) do
    with %{valid?: true} = changeset <- Investment.changeset(investment, attrs),
         {:ok, investment} <- Repo.update(changeset),
         {:ok, _investment_history} <-
           create_investment_history(%{
             investment_id: investment.id,
             value: investment.current_value
           }) do
      {:ok, investment}
    else
      {:error, changeset} -> {:error, changeset}
      changeset -> {:error, changeset}
    end
  end

  @doc """
  Upserts an investment with the given attributes.

  If an investment with the given name does not exist, it creates a new investment record.
  If an investment with the given name exists, and the `current_value` is different,
  it updates the existing record and creates an operation record of type `:update`.

  All changes are atomic. If any operation fails, all changes are rolled back.

  ## Examples

      iex> upsert_investment(%{name: "New Investment", current_value: 1000})
      {:ok, %Investment{}}

      iex> upsert_investment(%{name: "Existing Investment", current_value: 2000})
      {:ok, {:updated, %Investment{}, %Operation{}}}

  """
  @spec upsert_investment(map()) ::
          {:ok, Investment.t()}
          | {:ok, {:updated, Investment.t(), Operation.t()}}
          | {:error, Ecto.Changeset.t()}
  def upsert_investment(attrs) do
    name = Map.get(attrs, :name)
    new_current_value = Map.get(attrs, :current_value)

    case Repo.get_by(Investment, name: name) do
      nil -> create_investment(attrs)
      investment -> process_existing_investment(investment, new_current_value)
    end
  end

  defp process_existing_investment(investment, new_current_value) do
    if investment.current_value != new_current_value do
      update_existing_investment_and_create_operation(investment, new_current_value)
    else
      {:ok, investment}
    end
  end

  defp update_existing_investment_and_create_operation(investment, new_current_value) do
    Repo.transaction(fn ->
      operation_attrs = %{
        type: :update,
        value: new_current_value - investment.current_value,
        investment_id: investment.id
      }

      with {:ok, operation} <- create_operation(operation_attrs),
           {:ok, updated_investment} <-
             update_investment(investment, %{current_value: new_current_value}) do
        {:updated, updated_investment, operation}
      end
    end)
  end

  @doc """
  Deletes a investment.

  ## Examples

      iex> delete_investment(investment)
      {:ok, %Investment{}}

      iex> delete_investment(investment)
      {:error, %Ecto.Changeset{}}

  """
  @spec delete_investment(Investment.t()) :: {:ok, Investment.t()} | {:error, Ecto.Changeset.t()}
  def delete_investment(%Investment{} = investment) do
    Repo.delete(investment)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking investment changes.

  ## Examples

  iex> change_investment(investment)
  %Ecto.Changeset{data: %Investment{}}

  """
  @spec change_investment(map, map) :: Ecto.Changeset.t()
  def change_investment(%Investment{} = investment, attrs \\ %{}) do
    Investment.changeset(investment, attrs)
  end

  @doc """
  Returns the list of operations.

  ## Examples

  iex> list_operations()
  [%Operation{}, ...]

  """
  @spec list_operations :: [Operation.t()]
  def list_operations do
    Repo.all(Operation)
  end

  @doc """
  Gets a single operation.

  Raises `Ecto.NoResultsError` if the Operation does not exist.

  ## Examples

  iex> get_operation!(123)
  %Operation{}

  iex> get_operation!(456)
  ** (Ecto.NoResultsError)

  """
  @spec get_operation!(String.t()) :: Operation.t()
  def get_operation!(id), do: Repo.get!(Operation, id)

  @doc """
  Creates a operation.

  ## Examples

  iex> create_operation(%{field: value})
  {:ok, %Operation{}}

  iex> create_operation(%{field: bad_value})
  {:error, %Ecto.Changeset{}}

  """
  @spec create_operation(map) :: {:ok, Operation.t()} | {:error, Ecto.Changeset.t()}
  def create_operation(attrs \\ %{}) do
    %Operation{}
    |> Operation.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a operation.

  ## Examples

  iex> update_operation(operation, %{field: new_value})
  {:ok, %Operation{}}

  iex> update_operation(operation, %{field: bad_value})
  {:error, %Ecto.Changeset{}}

  """
  @spec update_operation(Operation.t(), map) ::
          {:ok, Operation.t()} | {:error, Ecto.Changeset.t()}
  def update_operation(%Operation{} = operation, attrs) do
    operation
    |> Operation.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a operation.

  ## Examples

  iex> delete_operation(operation)
  {:ok, %Operation{}}

  iex> delete_operation(operation)
  {:error, %Ecto.Changeset{}}
  """
  @spec delete_operation(Operation.t()) :: {:ok, Operation.t()} | {:error, Ecto.Changeset.t()}
  def delete_operation(%Operation{} = operation) do
    Repo.delete(operation)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking operation changes.

  ## Examples

  iex> change_operation(operation)
  %Ecto.Changeset{data: %Operation{}}

  """
  @spec change_operation(map, map) :: Ecto.Changeset.t()
  def change_operation(%Operation{} = operation, attrs \\ %{}) do
    Operation.changeset(operation, attrs)
  end

  @doc """
  Returns the list of investment_histories for a given investment.

  ## Examples

  iex> list_histories_for_investment(investment_id)
  [%InvestmentHistory{}, ...]

  """
  @spec list_histories_for_investment(String.t()) :: [InvestmentHistory.t()]
  def list_histories_for_investment(investment_id) do
    Repo.all(from ih in InvestmentHistory, where: ih.investment_id == ^investment_id)
  end

  @doc """
  Creates a investment_history.

  ## Examples

  iex> create_investment_history(%{field: value})
  {:ok, %InvestmentHistory{}}

  iex> create_investment_history(%{field: bad_value})
  {:error, %Ecto.Changeset{}}

  """
  @spec create_investment_history(map) ::
          {:ok, InvestmentHistory.t()} | {:error, Ecto.Changeset.t()}
  def create_investment_history(attrs \\ %{}) do
    %InvestmentHistory{}
    |> InvestmentHistory.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Deletes a investment_history.

  ## Examples

  iex> delete_investment_history(investment_history)
  {:ok, %InvestmentHistory{}}

  iex> delete_investment_history(investment_history)
  {:error, %Ecto.Changeset{}}

  """
  @spec delete_investment_history(InvestmentHistory.t()) ::
          {:ok, InvestmentHistory.t()} | {:error, Ecto.Changeset.t()}
  def delete_investment_history(%InvestmentHistory{} = investment_history) do
    Repo.delete(investment_history)
  end
end
