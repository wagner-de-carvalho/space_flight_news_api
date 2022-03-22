defmodule Spaceflightnewsapi.Repo.Migrations.ArticlesTable do
  use Ecto.Migration

  def change do
    create table(:articles) do
      add :featured, :boolean
      add :title, :string
      add :url, :string
      add :image_url, :string
      add :news_site, :string
      add :summary, :text
      add :published_at, :utc_datetime
      timestamps()
    end
  end
end
