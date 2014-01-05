defmodule Rethinkdb.Mixfile do
  use Mix.Project

  def project do
    [ app: :'rethinkdb',
      version: "0.2.2",
      elixir: "~> 0.12.1",
      deps: deps(Mix.env) ]
  end

  # Configuration for the OTP application
  def application do
    [
      mod: { Rethinkdb.App, [] },
      applications: [],
      env: Keyword.merge([{:timeout, 30}], env(Mix.env))
    ]
  end

  def env(:test) do
    [rethinkdb_uri: "rethinkdb://localhost:28015/elixir_drive_test"]
  end

  def env(_), do: []

  # Returns the list of dependencies in the format:
  def deps(:prod) do
    [
      { :protobuf, github: "cloud8421/elixir-protobuf" },
    ]
  end

  def deps(:test) do
    deps(:prod) ++ [
      {:meck, "0.7.2", github: "eproxus/meck", tag: "0.7.2"},
      {:mock, github: "jjh42/mock"}
    ]
  end

  def deps(:docs) do
    deps(:prod) ++
      [ { :ex_doc, github: "elixir-lang/ex_doc" } ]
  end

  def deps(_) do
    deps(:prod)
  end
end
