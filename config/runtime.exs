import Config

# config/runtime.exs is executed for all environments, including
# during releases. It is executed after compilation and before the
# system starts, so it is typically used to load production configuration
# and secrets from environment variables or elsewhere. Do not define
# any compile-time configuration in here, as it won't be applied.
# The block below contains prod specific runtime configuration.

# Start the phoenix server if environment is set and running in a release
if System.get_env("CTRLV_SERVER") && System.get_env("RELEASE_NAME") do
  config :ctrlv, CtrlvWeb.Endpoint, server: true
end

if config_env() == :prod do
  database_url =
    System.get_env("DATABASE_URL") ||
      raise """
      environment variable DATABASE_URL is missing.
      For example: ecto://USER:PASS@HOST/DATABASE
      """

  config :ctrlv, Ctrlv.Repo,
    # ssl: true,
    url: database_url,
    pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10"),
    port: 5432,
    socket_options: [:inet6]

  # The secret key base is used to sign/encrypt cookies and other secrets.
  # A default value is used in config/dev.exs and config/test.exs but you
  # want to use a different value for prod and you most likely don't want
  # to check this value into version control, so we use an environment
  # variable instead.
  secret_key_base =
    System.get_env("SECRET_KEY_BASE") ||
      raise """
      environment variable SECRET_KEY_BASE is missing.
      You can generate one by calling: mix phx.gen.secret
      """

  app_name =
    System.get_env("FLY_APP_NAME") ||
      raise "FLY_APP_NAME not available"

  phx_host = System.get_env("CTRLV_HOST")
  fly_host = "#{app_name}.fly.dev"
  host = phx_host || fly_host
  port = String.to_integer(System.get_env("PORT") || "4000")

  check_origins =
    if phx_host do
      ["https://" <> phx_host, "https://" <> fly_host]
    else
      ["https://" <> host]
    end

  config :ctrlv, CtrlvWeb.Endpoint,
    url: [host: host, port: 443, scheme: "https"],
    check_origin: check_origins,
    http: [
      # Enable IPv6 and bind on all interfaces.
      # Set it to  {0, 0, 0, 0, 0, 0, 0, 1} for local network only access.
      # See the documentation on https://hexdocs.pm/plug_cowboy/Plug.Cowboy.html
      # for details about using IPv6 vs IPv4 and loopback vs public addresses.
      ip: {0, 0, 0, 0, 0, 0, 0, 0},
      port: port
    ],
    secret_key_base: secret_key_base

  ## AWS

  config :ctrlv, Ctrlv.Integrations.AWS.Client,
    access_key_id: System.fetch_env!("AWS_ACCESS_KEY_ID"),
    secret_access_key: System.fetch_env!("AWS_SECRET_ACCESS_KEY"),
    region: System.get_env("AWS_REGION", "us-east-1")

  config :ctrlv, Ctrlv.Integrations.AWS.S3,
    bucket: System.fetch_env!("AWS_BUCKET")
end
