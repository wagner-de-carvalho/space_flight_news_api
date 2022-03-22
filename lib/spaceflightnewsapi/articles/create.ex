defmodule Spaceflightnewsapi.Articles.Create do
    use Ecto.Schema
    alias Spaceflightnewsapi.{Article, Error, Repo}
    alias Ecto.Changeset

    def call(params) do
        params
        |> Article.changeset()
        |> handle_insert()
    end

    defp handle_insert(%Changeset{valid?: true} = changeset) do
        changeset
        |> Repo.insert!()
        |> Repo.preload([:launches, :events])
    end

    defp handle_insert(%Changeset{valid?: false} = changeset) do
       {:error, Error.build(:error, changeset)}
    end
end
