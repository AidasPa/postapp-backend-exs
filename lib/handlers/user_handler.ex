defmodule PostApp.UserHandler do
  alias PostApp.Users

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
          err_code: 200,
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
