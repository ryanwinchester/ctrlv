defmodule CtrlvWeb.PageController do
  use CtrlvWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
