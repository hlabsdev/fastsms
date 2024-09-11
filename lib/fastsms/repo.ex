defmodule Fastsms.Repo do
  use Ecto.Repo,
    otp_app: :fastsms,
    adapter: Ecto.Adapters.Postgres
end
