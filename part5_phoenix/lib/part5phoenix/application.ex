defmodule Part5phoenix.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Part5phoenixWeb.Telemetry,
      Part5phoenix.Repo,
      {DNSCluster, query: Application.get_env(:part5phoenix, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Part5phoenix.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Part5phoenix.Finch},
      # Start a worker by calling: Part5phoenix.Worker.start_link(arg)
      # {Part5phoenix.Worker, arg},
      # Start to serve requests, typically the last entry
      Part5phoenixWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Part5phoenix.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    Part5phoenixWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
