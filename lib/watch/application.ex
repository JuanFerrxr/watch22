defmodule Watch.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      WatchWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Watch.PubSub},
      # Start the Endpoint (http/https)
      WatchWeb.Endpoint
      # Start a worker by calling: Watch.Worker.start_link(arg)
      # {Watch.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Watch.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    WatchWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
