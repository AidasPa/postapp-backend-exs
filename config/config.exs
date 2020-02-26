import Config

config :post_app, PostApp.Repo,
  database: "postapp",
  username: "root",
  password: "",
  hostname: "localhost",
  port: 3306

config :post_app, ecto_repos: [PostApp.Repo]
