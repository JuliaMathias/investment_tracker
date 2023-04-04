defmodule InvestmentTrackerWeb.CSVControllerTest do
  @moduledoc false
  use InvestmentTrackerWeb.ConnCase, async: true

  import InvestmentTracker.Factory

  @create_attrs %{content: "some content", title: "some title", type: :renda_fixa}
  @update_attrs %{content: "some updated content", title: "some updated title", type: :fundos}
  @invalid_attrs %{content: nil, title: nil, type: nil}

  describe "index" do
    test "lists all csvs", %{conn: conn} do
      conn = get(conn, ~p"/csvs")
      assert html_response(conn, 200) =~ "Listing Csvs"
    end
  end

  describe "new csv" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/csvs/new")
      assert html_response(conn, 200) =~ "New Csv"
    end
  end

  describe "create csv" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/csvs", csv: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/csvs/#{id}"

      conn = get(conn, ~p"/csvs/#{id}")
      assert html_response(conn, 200) =~ "Csv #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/csvs", csv: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Csv"
    end
  end

  describe "edit csv" do
    setup [:create_csv]

    test "renders form for editing chosen csv", %{conn: conn, csv: csv} do
      conn = get(conn, ~p"/csvs/#{csv}/edit")
      assert html_response(conn, 200) =~ "Edit Csv"
    end
  end

  describe "update csv" do
    setup [:create_csv]

    test "redirects when data is valid", %{conn: conn, csv: csv} do
      conn = put(conn, ~p"/csvs/#{csv}", csv: @update_attrs)
      assert redirected_to(conn) == ~p"/csvs/#{csv}"

      conn = get(conn, ~p"/csvs/#{csv}")
      assert html_response(conn, 200) =~ "some updated content"
    end

    test "renders errors when data is invalid", %{conn: conn, csv: csv} do
      conn = put(conn, ~p"/csvs/#{csv}", csv: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Csv"
    end
  end

  describe "delete csv" do
    setup [:create_csv]

    test "deletes chosen csv", %{conn: conn, csv: csv} do
      conn = delete(conn, ~p"/csvs/#{csv}")
      assert redirected_to(conn) == ~p"/csvs"

      assert_error_sent 404, fn ->
        get(conn, ~p"/csvs/#{csv}")
      end
    end
  end

  defp create_csv(_) do
    csv = insert(:csv)
    %{csv: csv}
  end
end
