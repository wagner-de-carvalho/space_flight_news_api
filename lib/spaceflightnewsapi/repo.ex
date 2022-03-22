defmodule Spaceflightnewsapi.Repo do
  use Scrivener, page_size: 3
  use Ecto.Repo,
    otp_app: :spaceflightnewsapi,
    adapter: Ecto.Adapters.Postgres
end
