defmodule Part6manyToMany.Repo do
  use Ecto.Repo,
    otp_app: :part6many_to_many,
    adapter: Ecto.Adapters.Postgres
end
