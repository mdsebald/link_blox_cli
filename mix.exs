defmodule LinkBloxCli.MixProject do
  use Mix.Project

  @target "host"

  def project do
    [
      app: :link_blox_cli,
      version: "0.1.0",
      elixir: "~> 1.7",
      erlc_options: erlc_options(@target),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      preferred_cli_env: [eunit: :test]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {LinkBloxCli.Application, [:LinkBloxCli, :lang_en_us, 1111, :debug, :LinkBlox_cookie]}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
      {:link_blox_cmn, path: "~/link_blox_cmn"},
      {:mix_eunit, github: "dantswain/mix_eunit", only: [:dev], runtime: false},
      {:dialyxir, "~> 0.5", only: [:dev], runtime: false}
    ]
  end

  defp erlc_options(_target) do
    if Mix.env() == :test do
      [{:d, :TEST}]
    else
      []
    end
  end
end
