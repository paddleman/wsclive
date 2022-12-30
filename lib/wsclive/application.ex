defmodule Wsclive.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      WscliveWeb.Telemetry,
      # Start the Ecto repository
      Wsclive.Repo,
      Wsclive.WscRepo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Wsclive.PubSub},
      # Start Finch
      {Finch, name: Wsclive.Finch},
      # Start the Endpoint (http/https)
      WscliveWeb.Endpoint
      # Start a worker by calling: Wsclive.Worker.start_link(arg)
      # {Wsclive.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Wsclive.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    WscliveWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
