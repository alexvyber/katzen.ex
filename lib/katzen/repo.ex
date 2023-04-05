defmodule Katzen.Repo do
  use Ecto.Repo,
    otp_app: :katzen,
    adapter: Ecto.Adapters.Postgres
end
