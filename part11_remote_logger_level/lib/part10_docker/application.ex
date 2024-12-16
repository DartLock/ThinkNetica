defmodule Part10Docker.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Part10DockerWeb.Telemetry,
      Part10Docker.Repo,
      {DNSCluster, query: Application.get_env(:part10_docker, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Part10Docker.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Part10Docker.Finch},
      # Start a worker by calling: Part10Docker.Worker.start_link(arg)
      # {Part10Docker.Worker, arg},
      # Start to serve requests, typically the last entry
      Part10DockerWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Part10Docker.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    Part10DockerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
