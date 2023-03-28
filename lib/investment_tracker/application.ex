defmodule InvestmentTracker.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      InvestmentTrackerWeb.Telemetry,
      # Start the Ecto repository
      InvestmentTracker.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: InvestmentTracker.PubSub},
      # Start Finch
      {Finch, name: InvestmentTracker.Finch},
      # Start the Endpoint (http/https)
      InvestmentTrackerWeb.Endpoint
      # Start a worker by calling: InvestmentTracker.Worker.start_link(arg)
      # {InvestmentTracker.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: InvestmentTracker.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    InvestmentTrackerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
