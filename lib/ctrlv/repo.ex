defmodule Ctrlv.Repo do
  use Ecto.Repo,
    otp_app: :ctrlv,
    adapter: Ecto.Adapters.Postgres
end
