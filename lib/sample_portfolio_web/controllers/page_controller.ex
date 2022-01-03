defmodule SamplePortfolioWeb.PageController do
  use SamplePortfolioWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
