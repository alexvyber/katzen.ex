defmodule Katzen.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      KatzenWeb.Telemetry,
      # Start the Ecto repository
      Katzen.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Katzen.PubSub},
      # Start Finch
      {Finch, name: Katzen.Finch},
      # Start the Endpoint (http/https)
      KatzenWeb.Endpoint
      # Start a worker by calling: Katzen.Worker.start_link(arg)
      # {Katzen.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Katzen.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    KatzenWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
