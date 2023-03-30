defmodule InvestmentTracker.Wallet do
  @moduledoc """
  The Wallet context.
  """

  import Ecto.Query, warn: false
  alias InvestmentTracker.Repo

  alias InvestmentTracker.Wallet.Investment

  @doc """
  Returns the list of investments.

  ## Examples

      iex> list_investments()
      [%Investment{}, ...]

  """
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
  def get_investment!(id), do: Repo.get!(Investment, id)

  @doc """
  Creates a investment.

  ## Examples

      iex> create_investment(%{field: value})
      {:ok, %Investment{}}

      iex> create_investment(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_investment(attrs \\ %{}) do
    %Investment{}
    |> Investment.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a investment.

  ## Examples

      iex> update_investment(investment, %{field: new_value})
      {:ok, %Investment{}}

      iex> update_investment(investment, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_investment(%Investment{} = investment, attrs) do
    investment
    |> Investment.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a investment.

  ## Examples

      iex> delete_investment(investment)
      {:ok, %Investment{}}

      iex> delete_investment(investment)
      {:error, %Ecto.Changeset{}}

  """
  def delete_investment(%Investment{} = investment) do
    Repo.delete(investment)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking investment changes.

  ## Examples

      iex> change_investment(investment)
      %Ecto.Changeset{data: %Investment{}}

  """
  def change_investment(%Investment{} = investment, attrs \\ %{}) do
    Investment.changeset(investment, attrs)
  end

  alias InvestmentTracker.Wallet.Operation

  @doc """
  Returns the list of operations.

  ## Examples

      iex> list_operations()
      [%Operation{}, ...]

  """
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
  def get_operation!(id), do: Repo.get!(Operation, id)

  @doc """
  Creates a operation.

  ## Examples

      iex> create_operation(%{field: value})
      {:ok, %Operation{}}

      iex> create_operation(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
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
  def delete_operation(%Operation{} = operation) do
    Repo.delete(operation)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking operation changes.

  ## Examples

      iex> change_operation(operation)
      %Ecto.Changeset{data: %Operation{}}

  """
  def change_operation(%Operation{} = operation, attrs \\ %{}) do
    Operation.changeset(operation, attrs)
  end
end
