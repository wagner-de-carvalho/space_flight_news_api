defmodule Spaceflightnewsapi.Client.Client do
    use Tesla

    plug Tesla.Middleware.BaseUrl, "https://api.spaceflightnewsapi.net/v3"
    plug Tesla.Middleware.Headers, [{"content-type", "application/json"}]
    plug Tesla.Middleware.JSON
    plug Tesla.Middleware.Retry,
    delay: 500,
    max_retries: 10,
    max_delay: 4_000
    plug Tesla.Middleware.Timeout, timeout: 2_000

    alias Spaceflightnewsapi.Error
    alias Spaceflightnewsapi.Response
    alias Tesla.Env

    def get_all(uri \\ "/articles") do
        "#{uri}"
        |> get()
        |> handle_response()
    end

    defp handle_response({:ok, %Env{body: body,  status: 200}}) do
        {:ok, Response.build(200, body)}
    end

    defp handle_response({:ok, %Env{body: body,  status: 404}}) do
        {:error, Error.build(404, body)}
    end

    defp handle_response({:ok, %Env{body: body,  status: 403}}) do
        {:error, Error.build(403, body)}
    end

    defp handle_response({:ok, %Env{body: body,  status: status}}) do
        {:error, Error.build(status, body)}
    end

end
