defmodule Dyn.Mixfile do
  use Mix.Project

  def project do
    [ app: :dyn,
      version: "0.0.1",
      dynamos: [Dyn.Dynamo],
      compilers: [:elixir, :dynamo, :app],
      env: [prod: [compile_path: "ebin"]],
      compile_path: "tmp/#{Mix.env}/dyn/ebin",
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    [ applications: [:cowboy, :dynamo],
      mod: { Dyn, [] } ]
  end

  defp deps do
    [
      { :cowboy, %r(.*), github: "extend/cowboy" },
      { :dynamo, "0.1.0.dev", github: "elixir-lang/dynamo" },
      { :httpotion,"0.1.0", [github: "myfreeweb/httpotion"] },
      { :jsonex, "2.0", [github: "marcelog/jsonex", tag: "2.0"] },
      { :epg_pool, %r".*", [github: "javierg/epg_pool"]}
    ]
  end
end
