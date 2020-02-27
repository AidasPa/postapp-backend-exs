defmodule PostApp.UserHandler do
  alias PostApp.Users
  alias PostApp.Posts
  alias PostApp.Response

  def index() do
    case Users.all() do
      nil ->
        %{
          status: :error,
          err_code: 404
        }

      users ->
        %{
          status: :ok,
          err_code: 200,
          resp: Poison.encode!(users)
        }
    end
  end

  def get_user_posts(params \\ %{}) do
    case Posts.get_by_user(params.id) do
      posts ->
        %{
          status: :ok,
          code: 200,
          resp: Poison.encode!(posts)
        }
    end
  end

  def new_user(params \\ %{}) do
    if Map.has_key?(params, "user") do
      case Users.create(params["user"]) do
        :ok ->
          %{
            status: :ok,
            code: 201,
            resp:
              Poison.encode!(%{
                status: "ok",
                message: "A new user has been created!"
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

  def get_user(params \\ %{}) do
    case Users.get(params.id) do
      nil ->
        %{
          status: :error,
          err_code: 404
        }

      user ->
        %{
          status: :ok,
          code: 200,
          resp:
            Poison.encode!(%{
              user: %{
                id: user.id,
                name: user.name,
                username: user.username,
                email: user.email
              }
            })
        }
    end
  end
end
