defmodule SpaceflightnewsapiWeb.FallbackController do
    use SpaceflightnewsapiWeb, :controller

    alias Spaceflightnewsapi.Error
    alias SpaceflightnewsapiWeb.ErrorView

    def call(conn, {:error, %Error{status: _status, result: result}}) do
      conn
      |> put_status(:not_found)
      |> put_view(ErrorView)
      |> render("error.json", result: result)
    end
  end
