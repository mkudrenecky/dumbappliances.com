defmodule Dumbappliances.Repo do
  use Ecto.Repo,
    otp_app: :dumbappliances,
    adapter: Ecto.Adapters.Postgres
end
