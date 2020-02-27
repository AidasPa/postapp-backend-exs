defmodule PostApp.Comments do
  import Ecto.Query, only: [where: 2]
  alias PostApp.Comment
  alias PostApp.Repo

  def create(comment \\ %{}) do
    changeset = Comment.changeset(%Comment{}, comment)

    case Repo.insert(changeset) do
      {:error, changeset} ->
        {:error, changeset.errors}

      {:ok, _comment} ->
        :ok
    end
  end

  def get_post_comments(post) do
    Comment
    |> where(postid: ^post)
    |> Repo.all()
    |> Enum.map(fn comment ->
      %{
        id: comment.id,
        title: comment.title,
        body: comment.body,
        author_email: comment.author_email
      }
    end)
  end
end
