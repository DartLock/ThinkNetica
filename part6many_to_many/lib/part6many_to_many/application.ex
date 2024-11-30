defmodule Part6manyToMany.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Part6manyToManyWeb.Telemetry,
      Part6manyToMany.Repo,
      {DNSCluster, query: Application.get_env(:part6many_to_many, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Part6manyToMany.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Part6manyToMany.Finch},
      # Start a worker by calling: Part6manyToMany.Worker.start_link(arg)
      # {Part6manyToMany.Worker, arg},
      # Start to serve requests, typically the last entry
      Part6manyToManyWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Part6manyToMany.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    Part6manyToManyWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
