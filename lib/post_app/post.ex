defmodule PostApp.Post do
  use Ecto.Schema
  alias Ecto.Changeset

  schema "posts" do
    field(:userid, :integer)
    field(:title, :string)
    field(:body, :string)
  end

  def changeset(user, params \\ %{}) do
    user
    |> Changeset.cast(params, [:userid, :title, :body])
    |> Changeset.validate_required([:userid, :title, :body])
  end
end
