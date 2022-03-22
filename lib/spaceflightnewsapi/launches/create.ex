defmodule Spaceflightnewsapi.Launches.Create do
    alias Spaceflightnewsapi.{Launch, Repo}

    def call(params) do
        params
        |> Launch.changeset()
        |> Repo.insert()
    end

    def call_many(list_params) do
        list_params
        |> Task.async_stream(&call/1)
        |> Enum.to_list()
    end
end
