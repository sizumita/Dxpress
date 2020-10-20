defmodule DxpressWeb.PageController do
  use DxpressWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
