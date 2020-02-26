defmodule PostApp.Application do
  use Application

  def start(_type, _args) do
    children = [
      PostApp.Repo,
      {Plug.Cowboy, scheme: :http, plug: PostApp.Router, options: [port: 4040]}
    ]

    opts = [strategy: :one_for_one, name: PostApp.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
