defmodule PostApp.Router do
  use Plug.Router
  alias PostApp.Response
  alias PostApp.UserHandler
  plug(:match)
  plug(:dispatch)

  def handle_route(conn, handler) do
    case handler do
      %{status: :ok} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, handler.resp)

      %{status: :error} ->
        error = handler.err_code

        conn
        |> put_resp_content_type("application/json")
        |> send_resp(error, Response.error(error))
    end
  end

  get "/users/all" do
    conn
    |> handle_route(UserHandler.index())
  end

  get "/users/:id" do
    conn
    |> handle_route(
      UserHandler.get_user(%{
        id: id
      })
    )
  end

  match _ do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(404, Response.error(404))
  end
end
