defmodule LinkBloxCli.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, args) do
    # List all child processes to be supervised
    children = [
      # Starts a worker by calling: LinkBloxCli.Worker.start_link(arg)
      %{
        id: :link_blox_cli,
        start: {:link_blox_cli, :start_link, [args]}
      }
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LinkBloxCli.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
