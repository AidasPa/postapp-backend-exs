defmodule PostApp.PostHandler do
  alias PostApp.Posts
  alias PostApp.Response

  def index() do
    case Posts.all() do
      nil ->
        %{
          status: :error,
          err_code: 404
        }

      posts ->
        %{
          status: :ok,
          code: 200,
          resp: Poison.encode!(posts)
        }
    end
  end

  def new_post(params) do
    if Map.has_key?(params, "post") do
      case Posts.create(params["post"]) do
        :ok ->
          %{
            status: :ok,
            code: 200,
            resp:
              Poison.encode!(%{
                message: "A new post has been created!",
                status: "ok"
              })
          }

        {:error, errors} ->
          %{
            status: :ok,
            code: 500,
            resp: Response.parse_changeset(errors)
          }
      end
    else
      %{
        status: :error,
        err_code: 500
      }
    end
  end

  def get_post(params \\ %{}) do
    case Posts.get(params.id) do
      nil ->
        %{
          status: :error,
          err_code: 404
        }

      post ->
        %{
          status: :ok,
          code: 200,
          resp:
            Poison.encode!(%{
              post: %{
                id: post.id,
                userid: post.userid,
                title: post.title,
                body: post.body
              }
            })
        }
    end
  end
end
