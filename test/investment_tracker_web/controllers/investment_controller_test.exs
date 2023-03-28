defmodule InvestmentTrackerWeb.InvestmentControllerTest do
  use InvestmentTrackerWeb.ConnCase

  import InvestmentTracker.WalletFixtures

  @create_attrs %{
    current_value: 42,
    expiration_date: ~D[2023-03-27],
    initial_value: 42,
    name: "some name",
    subtype: :selic,
    type: :tesouro_direto
  }
  @update_attrs %{
    current_value: 43,
    expiration_date: ~D[2023-03-28],
    initial_value: 43,
    name: "some updated name",
    subtype: :selic,
    type: :tesouro_direto
  }
  @invalid_attrs %{
    current_value: nil,
    expiration_date: nil,
    initial_value: nil,
    name: nil,
    subtype: nil,
    type: nil
  }

  describe "index" do
    test "lists all investments", %{conn: conn} do
      conn = get(conn, ~p"/investments")
      assert html_response(conn, 200) =~ "Listing Investments"
    end
  end

  describe "new investment" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/investments/new")
      assert html_response(conn, 200) =~ "New Investment"
    end
  end

  describe "create investment" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/investments", investment: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/investments/#{id}"

      conn = get(conn, ~p"/investments/#{id}")
      assert html_response(conn, 200) =~ "Investment #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/investments", investment: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Investment"
    end
  end

  describe "edit investment" do
    setup [:create_investment]

    test "renders form for editing chosen investment", %{conn: conn, investment: investment} do
      conn = get(conn, ~p"/investments/#{investment}/edit")
      assert html_response(conn, 200) =~ "Edit Investment"
    end
  end

  describe "update investment" do
    setup [:create_investment]

    test "redirects when data is valid", %{conn: conn, investment: investment} do
      conn = put(conn, ~p"/investments/#{investment}", investment: @update_attrs)
      assert redirected_to(conn) == ~p"/investments/#{investment}"

      conn = get(conn, ~p"/investments/#{investment}")
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, investment: investment} do
      conn = put(conn, ~p"/investments/#{investment}", investment: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Investment"
    end
  end

  describe "delete investment" do
    setup [:create_investment]

    test "deletes chosen investment", %{conn: conn, investment: investment} do
      conn = delete(conn, ~p"/investments/#{investment}")
      assert redirected_to(conn) == ~p"/investments"

      assert_error_sent 404, fn ->
        get(conn, ~p"/investments/#{investment}")
      end
    end
  end

  defp create_investment(_) do
    investment = investment_fixture()
    %{investment: investment}
  end
end
