defmodule Part10Docker.Repo do
  use Ecto.Repo,
    otp_app: :part10_docker,
    adapter: Ecto.Adapters.Postgres
end
