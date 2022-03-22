defmodule SpaceflightnewsapiWeb.ArticlesControllerTest  do
    use SpaceflightnewsapiWeb.ConnCase, async: true
    import Spaceflightnewsapi.Factory

    describe "create/2" do
        test "when all params are valid, creates new article", %{conn: conn} do
            params = build(:article_params_strings)

            response =
            conn
            |> post(Routes.articles_path(conn, :create, params))
            |> json_response(:created)
            assert %{
                "message" => "Article created"
            } = response
        end

        test "when there are invalid, returns an error", %{conn: conn} do
            params = build(:article_params_strings, %{"title" => ""})

            response =
            conn
            |> post(Routes.articles_path(conn, :create, params))
            |> json_response(:not_found)
            assert %{"message" => %{"title" => ["can't be blank"]}} = response
        end
    end

    describe "delete/2" do
        test "When id exists, deletes Article", %{conn: conn} do
            id = 1
            insert(:article)

            response =
                conn
                |> delete(Routes.articles_path(conn, :delete, id))
                |> response(:no_content)

            assert response == ""
        end

        test "When id does not exist, returns error", %{conn: conn} do
            id = 10
            insert(:article)

            response =
                conn
                |> delete(Routes.articles_path(conn, :delete, id))
                |> response(:not_found)

            assert response == "{\"message\":\"Article not found\"}"
        end
    end

    describe "index/2" do
        test "Show all articles", %{conn: conn} do
            response =
            conn
            |> get(Routes.articles_path(conn, :index))
            |> json_response(:ok)

            assert %{"articles" => []} = response
        end
    end

    describe "show/2" do
        test "When id does not exist, returns error", %{conn: conn} do
            id = 1000
            response =
            conn
            |> get(Routes.articles_path(conn, :show, id))
            |> json_response(:not_found)

            assert response == %{"message" => "Article not found"}
        end
    end
end
