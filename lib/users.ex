defmodule PostApp.Users do
  alias PostApp.Repo
  alias PostApp.User

  def get(id) do
    Repo.get_by(User, id: id)
  end
  def all() do
    Repo.all(User)
  end
  def create(user \\ %{}) do
    changeset = User.changeset(%User{}, user)
    case Repo.insert(changeset) do
      {:error, changeset} ->
        changeset.errors
      {:ok, _user} ->
        :ok
    end
  end
end
