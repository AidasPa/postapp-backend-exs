defmodule PostApp.Comment do
  use Ecto.Schema
  alias Ecto.Changeset

  schema "comments" do
    field(:postid, :integer)
    field(:author_email, :string)
    field(:title, :string)
    field(:body, :string)
  end

  def changeset(comment, params \\ %{}) do
    comment
    |> Changeset.cast(params, [:postid, :author_email, :title, :body])
    |> Changeset.validate_required([:postid, :author_email, :title, :body])
  end
end
