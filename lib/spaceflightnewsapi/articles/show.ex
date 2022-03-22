defmodule Spaceflightnewsapi.Articles.Show do
    use Ecto.Schema
    alias Spaceflightnewsapi.{Article, Repo}
    import Ecto.Query

    def call(params) do
        Article
        |> preload([:events, :launches])
        |> Repo.paginate(params)
        |> handle_result()
    end

    defp handle_result(%Scrivener.Page{} = page), do: {:ok, page}
end
