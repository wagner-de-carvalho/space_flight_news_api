defmodule SpaceflightnewsapiWeb.WelcomeController do
    use SpaceflightnewsapiWeb, :controller

    def welcome(conn, _params) do
      conn
      |> put_status(:ok)
      |> text("Back-end Challenge 2021 🏅 - Space Flight News")
    end
  end
