defmodule Spaceflightnewsapi.Factory do
    use ExMachina.Ecto, repo: Spaceflightnewsapi.Repo
    alias Spaceflightnewsapi.Helpers.Helper
    alias Spaceflightnewsapi.Article

    def article_params_atoms_factory do
        %{
            featured: true,
            title: "Titulo",
            url: "http://www.url.com.br",
            image_url: "http://www.url.com.br/images/icon.png",
            news_site: "http://www.url.com.br",
            summary: "Nova mensagem",
            published_at: "2021-12-04T22:56:18Z",
            events: [
              %{
                id: 1,
                provider: "event provider"
              }
            ],
            launches: [
              %{
                id: 1,
                provider: "launch provider"
              }
            ]
        }
    end

    def article_factory do
      %Article{
        featured: false,
        title: "SpaceX",
        url: "https://spaceflightnow.com/falcon-9/",
        image_url: "https://spaceflightnow.com/f9ixpestatic2.jpg",
        news_site: "Spaceflight Now",
        summary: "SpaceX completed.",
        published_at: "2021-12-05T04:36:00Z",
        id: 1,
        events: [],
        launches: [
          %{
            id: 1,
            provider: "Launch Library 2"
          },
          %{
            id: 3,
            provider:  nil
          }
        ]
      }
    end

    def article_params_strings_factory do
      %{
          "featured" => true,
          "title" => "Titulo",
          "url" => "http://www.url.com.br",
          "image_url" => "http://www.url.com.br/images/icon.png",
          "news_site" => "http://www.url.com.br",
          "summary" => "Nova mensagem",
          "published_at" => "2021-12-04T22:56:18Z"
      }
  end
end
