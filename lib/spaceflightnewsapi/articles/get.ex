defmodule Spaceflightnewsapi.Articles.Get do
    alias Spaceflightnewsapi.{Article, Error, Repo}

    def by_id(id) do
      case Repo.get(Article, id) do
        nil -> {:error, Error.build(404, "Article not found")}
        article ->
          {:ok, article |> Repo.preload([:events, :launches])}
      end
    end
end
