defmodule Spaceflightnewsapi.Routines.Routine do
    use Ecto.Schema
    alias Spaceflightnewsapi.Client.Client
    alias Spaceflightnewsapi.Helpers.Helper
    alias Spaceflightnewsapi.{Article, Error, Repo, Response}

    def load_data do
        Client.get_all()
        |> handle_response()
    end

    defp load(article) do
        Repo.transaction fn ->
            post =
                article
                |> Article.changeset()
                |> Repo.insert!()

            insert_association(post, :events, article["events"])
            insert_association(post, :launches, article["launches"])
        end
    end

    defp insert_association(article, association, params) do
        Stream.map(params, fn param ->
            Ecto.build_assoc(article, association, param)
        |> Repo.insert!
        end)
        |> Enum.to_list()
    end

    defp handle_response({:ok, %Response{result: result, status: 200}}) do
        result
        |> Task.async_stream(fn article ->
            Helper.format_keys(article)
            |> load()
        end)
        |> Enum.to_list()
    end

    defp handle_response({:ok, %Response{status: 400}}) do
        {:error, Error.build(400, :bad_request)}
    end

    defp handle_response({:ok, %Response{status: 404}}) do
        {:error, Error.build(404, :not_found)}
    end

    defp handle_response({:ok, %Response{status: 403}}) do
        {:error, Error.build(403, :forbidden)}
    end

    defp handle_response({:ok, %Response{status: status}}) do
        {:error, Error.build(status, "error")}
    end

    defp handle_response({:error, _}) do
        {:error, Error.build(400, "error")}
    end
end
