defmodule PostApp.MixProject do
  use Mix.Project

  def project do
    [
      app: :post_app,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {PostApp.Application, []}
    ]
  end

  defp deps do
    [
      {:ecto_sql, "~> 3.3.0"},
      {:myxql, "~> 0.3.0"},
      {:plug_cowboy, "~> 2.0"},
      {:poison, "~> 3.1"},
      # butinas del myxql, nes ecto skirtas postgres.
      {:db_connection, "~> 2.0", override: true}
    ]
  end
end
