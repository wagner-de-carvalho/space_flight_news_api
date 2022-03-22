defmodule Spaceflightnewsapi.Articles.Update do
    alias Spaceflightnewsapi.{Article, Error, Repo}
    use Ecto.Schema
    import Ecto.Changeset

    def call(%{"id" => id} = params) do
        case Repo.get(Article, id) do
        nil -> {:error, Error.build(404, "Article not found")}
        article -> do_update(article, params)
        end
    end

    defp do_update(article, params) do
        article
        |> Repo.preload([:events, :launches])
        |> Article.changeset(params)
        |> cast_assoc(:events)
        |> cast_assoc(:launches)
        |> Repo.update()
    end
end
