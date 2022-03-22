defmodule Spaceflightnewsapi.Articles.Delete do
    alias Spaceflightnewsapi.{Article, Error, Repo}

    def call(id) do
        case Repo.get(Article, id) do
            nil -> {:error, Error.build(404, "Article not found")}
            article -> Repo.delete(article)
        end
    end
end
