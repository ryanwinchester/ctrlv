defmodule Ctrlv.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @app :ctrlv

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Ctrlv.Repo,
      # Start the Telemetry supervisor
      CtrlvWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Ctrlv.PubSub},
      # Start the Endpoint (http/https)
      CtrlvWeb.Endpoint
      # Start a worker by calling: Ctrlv.Worker.start_link(arg)
      # {Ctrlv.Worker, arg}
      | schedules()
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Ctrlv.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CtrlvWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  # Get the schedules that should run.
  defp schedules do
    Application.fetch_env!(@app, Schedex) |> Keyword.fetch!(:schedules)
  end
end
