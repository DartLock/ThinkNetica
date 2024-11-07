defmodule Part5phoenix.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Part5phoenix.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: 42,
        name: "some name"
      })
      |> Part5phoenix.Accounts.create_user()

    user
  end
end
