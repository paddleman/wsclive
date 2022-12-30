defmodule Wsclive.Repo do
  use Ecto.Repo,
    otp_app: :wsclive,
    adapter: Ecto.Adapters.Postgres
end

defmodule Wsclive.WscRepo do
  use Ecto.Repo,
    otp_app: :wsclive,
    adapter: Ecto.Adapters.Postgres
end
