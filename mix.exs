defmodule HTTPet.MixProject do
  use Mix.Project

  def project do
    [
      app: :httpet,
      version: get_version(),
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      name: "HTTPet",
      description: "HTTP client for calls between services inside the Petlove ecosystem",
      package: package(),
      source_url: "https://github.com/petlove/httpet",
      docs: [main: "readme", extras: ["README.md"]],
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {HTTPet.Application, []},
      env: [
        services: [],
        tracer: nil
      ]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:excoveralls, "~> 0.18", only: :test},
      {:httpoison, ">= 1.8.0"},
      {:jason, "~> 1.2"},
      {:mox, "~> 1.0", only: :test},
      {:sobelow, "~> 0.14", only: [:dev, :test], runtime: false}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end

  # The version comes from the release tag, never this file: HTTPET_VERSION when
  # publishing, else the v* tag (own checkout or git dep), else the version Hex recorded
  # when it installed the package, else 0.0.0-dev. Only an exactly tagged checkout gets
  # the tag's version; N commits past v1.0.0 is 1.0.1-dev.N+<sha>, which sorts after
  # 1.0.0 and before 1.0.1.
  defp get_version do
    env_version() || tag_version() || hex_version() || "0.0.0-dev"
  end

  defp env_version do
    case System.get_env("HTTPET_VERSION", "") |> String.trim() do
      "" -> nil
      version -> version
    end
  end

  # Only with a .git next to this file: anywhere else git would walk up into whatever
  # repo the dep sits in.
  defp tag_version do
    args = ["describe", "--tags", "--long", "--match", "v*"]

    with true <- File.exists?(Path.join(__DIR__, ".git")),
         {out, 0} <- System.cmd("git", args, cd: __DIR__, stderr_to_stdout: true),
         [_, major, minor, patch, since, sha] <-
           Regex.run(~r/\Av(\d+)\.(\d+)\.(\d+)-(\d+)-g([0-9a-f]+)\z/, String.trim(out)) do
      case since do
        "0" -> "#{major}.#{minor}.#{patch}"
        _ -> "#{major}.#{minor}.#{String.to_integer(patch) + 1}-dev.#{since}+#{sha}"
      end
    else
      _ -> nil
    end
  rescue
    # git isn't installed
    ErlangError -> nil
  end

  # Installed from Hex there's no .git and no env var, but Hex writes the published
  # version to hex_metadata.config in the dep's directory.
  defp hex_version do
    with {:ok, terms} <- :file.consult(Path.join(__DIR__, "hex_metadata.config")),
         {_, version} <- List.keyfind(terms, "version", 0) do
      version
    else
      _ -> nil
    end
  end

  defp package do
    [
      name: :httpet,
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/petlove/httpet"
      },
      files: ~w(lib .formatter.exs LICENSE mix.exs README.md)
    ]
  end
end
