defmodule Coliving.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      #Starts Telemetry
      ColivingWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: ColivingWeb.PubSub},
      # Start the Ecto repository
      Coliving.Repo,
      # Start the endpoint when the application starts
      ColivingWeb.Endpoint
      # Starts a worker by calling: Coliving.Worker.start_link(arg)
      # {Coliving.Worker, arg},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Coliving.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ColivingWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
