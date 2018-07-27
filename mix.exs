defmodule Iugu.Mixfile do
  use Mix.Project

  def project do
    [
      app: :iugu,
      version: "0.1.0",
      elixir: "~> 1.3",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps(),
      dialyzer: [plt_add_deps: :project, plt_add_apps: [:httpoison]],
      # Docs
      name: "Iugu",
      source_url: "https://github.com/tiagopog/iugu-elixir",
      homepage_url: "https://github.com/tiagopog/iugu-elixir",
      docs: [
        main: "README",
        extras: ["README.md"]
      ]
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :httpoison]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:httpoison, "~> 1.0"},
      {:poison, "~> 3.1"},
      {:dialyxir, "~> 0.5", only: [:dev], runtime: false},
      {:ex_doc, "~> 0.19.0", only: :dev, runtime: false},
      {:exvcr, "~> 0.10", only: [:dev, :test]}
    ]
  end
end
