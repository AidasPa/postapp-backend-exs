defmodule PostApp.Users do
  alias PostApp.Repo
  alias PostApp.User

  def get(id) do
    Repo.get_by(User, id: id)
  end

  def create(user \\ %{}) do
    user = %User{}

    user
    |> User.changeset(user)
    |> Repo.insert()
  end
end
