defmodule SpaceflightnewsapiWeb.ArticlesController  do
    use SpaceflightnewsapiWeb, :controller

    alias Spaceflightnewsapi.Article
    alias SpaceflightnewsapiWeb.FallbackController

    action_fallback FallbackController

    def create(conn, params) do
        with %Article{} = article <- Spaceflightnewsapi.create_article(params) do
            conn
            |> put_status(:created)
            |> render("create.json", article: article)
        end
    end

    def delete(conn, %{"id" => id}) do
        with {:ok, %Article{}} <- Spaceflightnewsapi.delete_article(id) do
            conn
            |> put_status(:no_content)
            |> text("")
        end
    end

    def show(conn, %{"id" => id}) do
        with {:ok, %Article{} = article} <- Spaceflightnewsapi.find_by_id(id) do
            conn
            |> put_status(:ok)
            |> render("article.json", article: article)
        end
    end

    def index(conn, params) do
        with {:ok, articles} <- Spaceflightnewsapi.show_all(params) do
            conn
            |> put_status(:ok)
            |> render("articles.json", articles: articles.entries, page: articles)
        end
    end

    def update(conn, params) do
        with {:ok, %Article{} = article} <- Spaceflightnewsapi.update_article(params) do
            conn
            |> put_status(:ok)
            |> render("article.json", article: article)
        end
    end
end
