defmodule Notable.Web.PageController do
  use Notable.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
