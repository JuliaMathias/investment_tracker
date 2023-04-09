defmodule InvestmentTrackerWeb.CSVControllerTest do
  @moduledoc false
  use InvestmentTrackerWeb.ConnCase, async: true

  import InvestmentTracker.Factory

  alias InvestmentTracker.CSVs

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
    test "renders import template with imported data when data is valid", %{conn: conn} do
      attrs = params_for(:fundos_csv)

      # create investments

      CSVs.import_csv(attrs)

      # update investments

      update_attrs = %{title: title} = params_for(:update_fundos_csv)

      conn = post(conn, ~p"/csvs", csv: update_attrs)

      assert html_response(conn, 200) =~ "Csv #{title}"

      assert html_response(conn, 200) =~ "Investments"
      assert html_response(conn, 200) =~ "ANON ACCESS ABC CAPITAL FIM"
      assert html_response(conn, 200) =~ "DAICHI KARAZUNO FIC FIM CP"
      assert html_response(conn, 200) =~ "ANON ACCESS TRIGONOMETRY BS FIC FIM"
      assert html_response(conn, 200) =~ "CALIFORNIAN WHATEVER US INDEX 500 FIM"
      assert html_response(conn, 200) =~ "ANON RENDA AMAZING FIRF LP"
      assert html_response(conn, 200) =~ "CUTE HAMTARO STH FIC FIM"
      assert html_response(conn, 200) =~ "ANON RENDA FIRF CP"
      assert html_response(conn, 200) =~ "ANON RARE FIRF CP"
      assert html_response(conn, 200) =~ "ANON SELECTION MULTIESTRATEGIA FIC FIM"
      assert html_response(conn, 200) =~ "ALPHA OMEGA GLOBAL FIC FIM"

      assert html_response(conn, 200) =~ "Investment Histories"
      assert html_response(conn, 200) =~ "689292"
      assert html_response(conn, 200) =~ "699292"

      assert html_response(conn, 200) =~ "Operations"

      assert html_response(conn, 200) =~ "10000"
      assert html_response(conn, 200) =~ "-500"
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
