defmodule Part10Docker.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Part10Docker.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "email_1@mail.com",
        name: "some name"
      })
      |> Part10Docker.Accounts.create_user()

    user
  end
end
