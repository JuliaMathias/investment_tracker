defmodule InvestmentTracker.CSVsTest do
  use InvestmentTracker.DataCase

  alias InvestmentTracker.CSVs

  describe "csvs" do
    alias InvestmentTracker.CSVs.CSV

    import InvestmentTracker.CSVsFixtures

    @invalid_attrs %{content: nil, title: nil, type: nil}

    test "list_csvs/0 returns all csvs" do
      csv = csv_fixture()
      assert CSVs.list_csvs() == [csv]
    end

    test "get_csv!/1 returns the csv with given id" do
      csv = csv_fixture()
      assert CSVs.get_csv!(csv.id) == csv
    end

    test "create_csv/1 with valid data creates a csv" do
      valid_attrs = %{content: "some content", title: "some title", type: :renda_fixa}

      assert {:ok, %CSV{} = csv} = CSVs.create_csv(valid_attrs)
      assert csv.content == "some content"
      assert csv.title == "some title"
      assert csv.type == :renda_fixa
    end

    test "create_csv/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = CSVs.create_csv(@invalid_attrs)
    end

    test "update_csv/2 with valid data updates the csv" do
      csv = csv_fixture()
      update_attrs = %{content: "some updated content", title: "some updated title", type: :fundos}

      assert {:ok, %CSV{} = csv} = CSVs.update_csv(csv, update_attrs)
      assert csv.content == "some updated content"
      assert csv.title == "some updated title"
      assert csv.type == :fundos
    end

    test "update_csv/2 with invalid data returns error changeset" do
      csv = csv_fixture()
      assert {:error, %Ecto.Changeset{}} = CSVs.update_csv(csv, @invalid_attrs)
      assert csv == CSVs.get_csv!(csv.id)
    end

    test "delete_csv/1 deletes the csv" do
      csv = csv_fixture()
      assert {:ok, %CSV{}} = CSVs.delete_csv(csv)
      assert_raise Ecto.NoResultsError, fn -> CSVs.get_csv!(csv.id) end
    end

    test "change_csv/1 returns a csv changeset" do
      csv = csv_fixture()
      assert %Ecto.Changeset{} = CSVs.change_csv(csv)
    end
  end
end
