defmodule Notable.Accounts.UserResolver do
  alias Notable.{Accounts.User, Repo}

  def all(_args, _info) do
    {:ok, Repo.all(User)}
  end
end
