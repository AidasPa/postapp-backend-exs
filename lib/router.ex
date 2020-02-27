defmodule PostApp.Router do
  use Plug.Router
  alias PostApp.Response

  alias PostApp.UserHandler
  alias PostApp.PostHandler
  alias PostApp.CommentHandler

  plug(:match)

  plug(Plug.Parsers,
    parsers: [:json],
    pass: ["application/json"],
    json_decoder: Poison
  )

  plug(:dispatch)

  def handle_route(conn, handler) do
    IO.inspect(handler)

    case handler do
      %{status: :ok} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(handler.code, handler.resp)

      %{status: :error} ->
        error = handler.err_code

        conn
        |> put_resp_content_type("application/json")
        |> send_resp(error, Response.error(error))
    end
  end

  post "/comments/new" do
    conn
    |> handle_route(CommentHandler.new_comment(conn.params))
  end

  post "/posts/new" do
    conn
    |> handle_route(PostHandler.new_post(conn.params))
  end

  get "/posts/all" do
    conn
    |> handle_route(PostHandler.index())
  end

  get "/posts/:id/comments" do
    conn
    |> handle_route(
      CommentHandler.get_post_comments(%{
        id: id
      })
    )
  end

  get "/posts/:id" do
    conn
    |> handle_route(
      PostHandler.get_post(%{
        id: id
      })
    )
  end

  post "/users/new" do
    conn
    |> handle_route(UserHandler.new_user(conn.params))
  end

  get "/users/all" do
    conn
    |> handle_route(UserHandler.index())
  end

  get "/users/:id/posts" do
    conn
    |> handle_route(
      UserHandler.get_user_posts(%{
        id: id
      })
    )
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
