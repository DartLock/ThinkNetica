defmodule Part5phoenix.Repo do
  use Ecto.Repo,
    otp_app: :part5phoenix,
    adapter: Ecto.Adapters.Postgres
end
