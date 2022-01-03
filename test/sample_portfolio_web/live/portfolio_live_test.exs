defmodule SamplePortfolioWeb.PortfolioLiveTest do
  use SamplePortfolioWeb.ConnCase

  import Phoenix.LiveViewTest
  import SamplePortfolio.PortfoliosFixtures

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  defp create_portfolio(_) do
    portfolio = portfolio_fixture()
    %{portfolio: portfolio}
  end

  describe "Index" do
    setup [:create_portfolio]

    test "lists all portfolios", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, Routes.portfolio_index_path(conn, :index))

      assert html =~ "Listing Portfolios"
    end

    test "saves new portfolio", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.portfolio_index_path(conn, :index))

      assert index_live |> element("a", "New Portfolio") |> render_click() =~
               "New Portfolio"

      assert_patch(index_live, Routes.portfolio_index_path(conn, :new))

      assert index_live
             |> form("#portfolio-form", portfolio: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#portfolio-form", portfolio: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.portfolio_index_path(conn, :index))

      assert html =~ "Portfolio created successfully"
    end

    test "updates portfolio in listing", %{conn: conn, portfolio: portfolio} do
      {:ok, index_live, _html} = live(conn, Routes.portfolio_index_path(conn, :index))

      assert index_live |> element("#portfolio-#{portfolio.id} a", "Edit") |> render_click() =~
               "Edit Portfolio"

      assert_patch(index_live, Routes.portfolio_index_path(conn, :edit, portfolio))

      assert index_live
             |> form("#portfolio-form", portfolio: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#portfolio-form", portfolio: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.portfolio_index_path(conn, :index))

      assert html =~ "Portfolio updated successfully"
    end

    test "deletes portfolio in listing", %{conn: conn, portfolio: portfolio} do
      {:ok, index_live, _html} = live(conn, Routes.portfolio_index_path(conn, :index))

      assert index_live |> element("#portfolio-#{portfolio.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#portfolio-#{portfolio.id}")
    end
  end

  describe "Show" do
    setup [:create_portfolio]

    test "displays portfolio", %{conn: conn, portfolio: portfolio} do
      {:ok, _show_live, html} = live(conn, Routes.portfolio_show_path(conn, :show, portfolio))

      assert html =~ "Show Portfolio"
    end

    test "updates portfolio within modal", %{conn: conn, portfolio: portfolio} do
      {:ok, show_live, _html} = live(conn, Routes.portfolio_show_path(conn, :show, portfolio))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Portfolio"

      assert_patch(show_live, Routes.portfolio_show_path(conn, :edit, portfolio))

      assert show_live
             |> form("#portfolio-form", portfolio: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#portfolio-form", portfolio: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.portfolio_show_path(conn, :show, portfolio))

      assert html =~ "Portfolio updated successfully"
    end
  end
end
