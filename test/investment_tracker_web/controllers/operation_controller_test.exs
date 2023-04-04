defmodule InvestmentTrackerWeb.OperationControllerTest do
  @moduledoc false
  use InvestmentTrackerWeb.ConnCase, async: true

  import InvestmentTracker.Factory

  @create_attrs %{type: :deposit, value: 42}
  @update_attrs %{type: :deposit, value: 43}
  @invalid_attrs %{type: nil, value: nil}

  describe "index" do
    test "lists all operations", %{conn: conn} do
      conn = get(conn, ~p"/operations")
      assert html_response(conn, 200) =~ "Listing Operations"
    end
  end

  describe "new operation" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/operations/new")
      assert html_response(conn, 200) =~ "New Operation"
    end
  end

  describe "create operation" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/operations", operation: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/operations/#{id}"

      conn = get(conn, ~p"/operations/#{id}")
      assert html_response(conn, 200) =~ "Operation #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/operations", operation: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Operation"
    end
  end

  describe "edit operation" do
    setup [:create_operation]

    test "renders form for editing chosen operation", %{conn: conn, operation: operation} do
      conn = get(conn, ~p"/operations/#{operation}/edit")
      assert html_response(conn, 200) =~ "Edit Operation"
    end
  end

  describe "update operation" do
    setup [:create_operation]

    test "redirects when data is valid", %{conn: conn, operation: operation} do
      conn = put(conn, ~p"/operations/#{operation}", operation: @update_attrs)
      assert redirected_to(conn) == ~p"/operations/#{operation}"

      conn = get(conn, ~p"/operations/#{operation}")
      assert html_response(conn, 200) =~ "deposit"
    end

    test "renders errors when data is invalid", %{conn: conn, operation: operation} do
      conn = put(conn, ~p"/operations/#{operation}", operation: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Operation"
    end
  end

  describe "delete operation" do
    setup [:create_operation]

    test "deletes chosen operation", %{conn: conn, operation: operation} do
      conn = delete(conn, ~p"/operations/#{operation}")
      assert redirected_to(conn) == ~p"/operations"

      assert_error_sent 404, fn ->
        get(conn, ~p"/operations/#{operation}")
      end
    end
  end

  defp create_operation(_) do
    operation = insert(:operation)
    %{operation: operation}
  end
end
