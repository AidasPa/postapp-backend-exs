defmodule PostApp.User do
  use Ecto.Schema
  alias Ecto.Changeset

  schema "users" do
    field(:name, :string)
    field(:username, :string)
    field(:email, :string)
  end

  def changeset(user, params \\ %{}) do
    user
    |> Changeset.cast(params, [:name, :username, :email])
    |> Changeset.unique_constraint(:email)
    |> Changeset.validate_format(:email, ~r/@/)
    |> Changeset.validate_required([:name, :username, :email])
  end
end
