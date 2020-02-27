defmodule PostApp.Users do
  alias PostApp.Repo
  alias PostApp.User

  def get(id) do
    Repo.get_by(User, id: id)
  end

  def all() do
    Enum.map(Repo.all(User), fn user ->
      %{
        id: user.id,
        name: user.name,
        username: user.username,
        email: user.email
      }
    end)
  end

  def create(user \\ %{}) do
    changeset = User.changeset(%User{}, user)

    case Repo.insert(changeset) do
      {:error, changeset} ->
        {:error, changeset.errors}

      {:ok, _user} ->
        :ok
    end
  end
end
