defmodule Spaceflightnewsapi.Events.Create do
    alias Spaceflightnewsapi.{Event, Repo}

    def call(params) do
        params
        |> Event.changeset()
        |> Repo.insert()
    end

    def call_many(list_params) do
        list_params
        |> Task.async_stream(&call/1)
        |> Enum.to_list()
    end
end
