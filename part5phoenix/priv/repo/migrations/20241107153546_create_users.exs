defmodule Part5phoenix.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :email, :integer

      timestamps(type: :utc_datetime)
    end
  end
end
