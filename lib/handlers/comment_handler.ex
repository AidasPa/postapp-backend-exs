defmodule PostApp.CommentHandler do
  alias PostApp.Comments
  alias PostApp.Response

  def new_comment(params) do
    if Map.has_key?(params, "comment") do
      case Comments.create(params["comment"]) do
        :ok ->
          %{
            status: :ok,
            code: 201,
            resp:
              Poison.encode!(%{
                status: "ok",
                message: "A new comment has been created!"
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

  def get_post_comments(params \\ %{}) do
    case(Comments.get_post_comments(params.id)) do
      [] ->
        %{
          status: :error,
          err_code: 404
        }

      comments ->
        %{
          status: :ok,
          code: 200,
          resp: Poison.encode!(comments)
        }
    end
  end
end
