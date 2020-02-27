defmodule PostApp.Posts do
  import Ecto.Query, only: [where: 2]
  alias PostApp.Post
  alias PostApp.Repo

  def all() do
    Enum.map(Repo.all(Post), fn post ->
      %{
        id: post.id,
        userid: post.userid,
        title: post.title,
        body: post.body
      }
    end)
  end

  def get(id) do
    Repo.get_by(Post, id: id)
  end

  def create(post \\ %{}) do
    changeset = Post.changeset(%Post{}, post)

    case Repo.insert(changeset) do
      {:error, changeset} ->
        {:error, changeset.errors}

      {:ok, _post} ->
        :ok
    end
  end

  def get_by_user(user) do
    Post
    |> where(userid: ^user)
    |> Repo.all()
    |> Enum.map(fn post ->
      %{
        id: post.id,
        title: post.title,
        body: post.body
      }
    end)
  end
end
