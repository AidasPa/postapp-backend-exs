defmodule PostApp.Router do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  get "/test" do
    send_resp(conn, 200, "yeet")
  end

  match _ do
    send_resp(conn, 404, "not found")
  end
end
